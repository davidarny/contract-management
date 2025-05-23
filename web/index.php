<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Primary Meta Tags -->
    <title>Contract Templates - Professional Legal Document Templates | Free Download</title>
    <meta name="title" content="Contract Templates - Professional Legal Document Templates | Free Download">
    <meta name="description" content="Download professional contract templates for employment, NDA, freelance, construction, and more. Save time with our comprehensive library of legal document templates.">
    <meta name="keywords" content="contract templates, legal documents, employment contract, NDA template, freelance agreement, construction contract, business templates, legal forms">
    <meta name="author" content="Contract Templates">
    <meta name="robots" content="index, follow">
    <meta name="language" content="English">
    <meta name="revisit-after" content="7 days">
    
    <!-- Open Graph / Facebook -->
    <meta property="og:type" content="website">
    <meta property="og:url" content="https://contractdatahub.tech/">
    <meta property="og:title" content="Contract Templates - Professional Legal Document Templates">
    <meta property="og:description" content="Download professional contract templates for employment, NDA, freelance, construction, and more. Save time with our comprehensive library of legal document templates.">
    <meta property="og:site_name" content="Contract Templates">
    <meta property="og:locale" content="en_US">
    
    <!-- Twitter -->
    <meta property="twitter:card" content="summary">
    <meta property="twitter:url" content="https://contractdatahub.tech/">
    <meta property="twitter:title" content="Contract Templates - Professional Legal Document Templates">
    <meta property="twitter:description" content="Download professional contract templates for employment, NDA, freelance, construction, and more. Save time with our comprehensive library of legal document templates.">
    <meta name="twitter:creator" content="@contractdatahub">
    <meta name="twitter:site" content="@contractdatahub">
    
    <!-- Technical Meta Tags -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="format-detection" content="telephone=no">
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="default">
    <meta name="apple-mobile-web-app-title" content="Contract Templates">
    <meta name="application-name" content="Contract Templates">
    <meta name="msapplication-TileColor" content="#2563eb">
    <meta name="theme-color" content="#2563eb">
    
    <!-- Favicon -->
    <link rel="icon" type="image/png" href="/public/favicon-96x96.png" sizes="96x96" />
    <link rel="icon" type="image/svg+xml" href="/public/favicon.svg" />
    <link rel="shortcut icon" href="/public/favicon.ico" />
    <link rel="apple-touch-icon" sizes="180x180" href="/public/apple-touch-icon.png" />
    <meta name="apple-mobile-web-app-title" content="Contract Templates" />
    <link rel="manifest" href="/public/site.webmanifest" />
    
    <!-- Canonical URL -->
    <link rel="canonical" href="https://contractdatahub.tech/">
    
    <!-- Preconnect for Performance -->
    <link rel="preconnect" href="https://cdn.tailwindcss.com">
    <link rel="preconnect" href="https://unpkg.com">
    
    <!-- DNS Prefetch -->
    <link rel="dns-prefetch" href="//cdn.tailwindcss.com">
    <link rel="dns-prefetch" href="//unpkg.com">
    
    <!-- External Resources -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js" defer></script>
    
    <style>
        [x-cloak] { display: none !important; }

        .line-clamp-2 {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen">
    <?php
    // All contract templates data
    $templates = [
        [
            'id' => 1,
            'title' => 'Employment Contract Template',
            'category' => 'Employment',
            'description' => 'Comprehensive employment agreement template covering terms, conditions, and responsibilities.',
            'tags' => ['employment', 'hr', 'legal'],
            'popular' => true,
            'featured' => true
        ],
        [
            'id' => 2,
            'title' => 'Non-Disclosure Agreement (NDA)',
            'category' => 'Legal',
            'description' => 'Protect confidential information with this comprehensive NDA template.',
            'tags' => ['nda', 'confidentiality', 'legal'],
            'popular' => true,
            'featured' => true
        ],
        [
            'id' => 3,
            'title' => 'Freelance Contract Template',
            'category' => 'Consulting',
            'description' => 'Professional freelance agreement template for independent contractors.',
            'tags' => ['freelance', 'consulting', 'independent'],
            'popular' => true,
            'featured' => false
        ],
        [
            'id' => 4,
            'title' => 'Service Agreement Template',
            'category' => 'Business',
            'description' => 'Standard service agreement for business-to-business transactions.',
            'tags' => ['service', 'business', 'agreement'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 5,
            'title' => 'Rental Lease Agreement',
            'category' => 'Real Estate',
            'description' => 'Comprehensive rental agreement for residential properties.',
            'tags' => ['rental', 'lease', 'property'],
            'popular' => true,
            'featured' => false
        ],
        [
            'id' => 6,
            'title' => 'Photography Contract',
            'category' => 'Creative',
            'description' => 'Professional photography services contract template.',
            'tags' => ['photography', 'creative', 'services'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 7,
            'title' => 'Construction Contract',
            'category' => 'Construction',
            'description' => 'Detailed construction agreement template for building projects.',
            'tags' => ['construction', 'building', 'project'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 8,
            'title' => 'Sales Representative Contract',
            'category' => 'Sales',
            'description' => 'Commission-based sales representative agreement template.',
            'tags' => ['sales', 'commission', 'representative'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 9,
            'title' => 'Consulting Agreement',
            'category' => 'Consulting',
            'description' => 'Professional consulting services agreement template.',
            'tags' => ['consulting', 'professional', 'services'],
            'popular' => true,
            'featured' => false
        ],
        [
            'id' => 10,
            'title' => 'Partnership Agreement',
            'category' => 'Business',
            'description' => 'Business partnership agreement template for joint ventures.',
            'tags' => ['partnership', 'business', 'joint venture'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 11,
            'title' => 'Software License Agreement',
            'category' => 'Technology',
            'description' => 'Software licensing agreement for technology products.',
            'tags' => ['software', 'license', 'technology'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 12,
            'title' => 'Event Planning Contract',
            'category' => 'Events',
            'description' => 'Comprehensive event planning services contract template.',
            'tags' => ['events', 'planning', 'services'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 13,
            'title' => 'Marketing Services Agreement',
            'category' => 'Marketing',
            'description' => 'Digital marketing services agreement template.',
            'tags' => ['marketing', 'digital', 'services'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 14,
            'title' => 'Vendor Agreement',
            'category' => 'Business',
            'description' => 'Vendor services agreement for business suppliers.',
            'tags' => ['vendor', 'supplier', 'business'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 15,
            'title' => 'Intellectual Property Agreement',
            'category' => 'Legal',
            'description' => 'Intellectual property rights and licensing agreement.',
            'tags' => ['ip', 'intellectual property', 'legal'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 16,
            'title' => 'Excavation Contract Template',
            'category' => 'Construction',
            'description' => 'Set terms and conditions for your excavation project with this comprehensive template.',
            'tags' => ['excavation', 'construction', 'earthwork'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 17,
            'title' => 'Dog Breeding Contract Template',
            'category' => 'Animals',
            'description' => 'Ensure everything goes smoothly with a dog breeding contract outlining all requirements.',
            'tags' => ['dog breeding', 'animals', 'pets'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 18,
            'title' => 'AI Contract Template',
            'category' => 'Technology',
            'description' => 'Secure and clear AI partnership template tailored for AI service agreements.',
            'tags' => ['ai', 'artificial intelligence', 'technology'],
            'popular' => true,
            'featured' => true
        ],
        [
            'id' => 19,
            'title' => 'Residential Construction Contract',
            'category' => 'Construction',
            'description' => 'Comprehensive agreement template for residential construction projects.',
            'tags' => ['residential', 'construction', 'building'],
            'popular' => true,
            'featured' => false
        ],
        [
            'id' => 20,
            'title' => 'Travel Nurse Contract Template',
            'category' => 'Healthcare',
            'description' => 'Contract covering compensation, duties, and employment terms for temporary nursing assignments.',
            'tags' => ['travel nurse', 'healthcare', 'nursing'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 21,
            'title' => 'Drywall Contract Template',
            'category' => 'Construction',
            'description' => 'Secure agreement explaining drywall services, compensation, and job terms.',
            'tags' => ['drywall', 'construction', 'interior'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 22,
            'title' => 'Wedding Cake Contract Template',
            'category' => 'Events',
            'description' => 'Wedding cake contract ensuring all terms are clear between baker and client.',
            'tags' => ['wedding cake', 'events', 'catering'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 23,
            'title' => 'Puppy Contract Template',
            'category' => 'Animals',
            'description' => 'Protect breeder and buyer with customizable puppy contract covering pricing and health guarantees.',
            'tags' => ['puppy', 'animals', 'breeding'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 24,
            'title' => 'Home Remodel Contract Template',
            'category' => 'Construction',
            'description' => 'Legally binding contract defining scope, cost, and expectations for remodeling projects.',
            'tags' => ['home remodel', 'construction', 'renovation'],
            'popular' => true,
            'featured' => false
        ],
        [
            'id' => 25,
            'title' => 'Pool Remodel Contract Template',
            'category' => 'Construction',
            'description' => 'Ensure clients understand job scope, compensation, and terms for pool remodeling.',
            'tags' => ['pool remodel', 'construction', 'swimming pool'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 26,
            'title' => 'Kitchen Remodel Contract Template',
            'category' => 'Construction',
            'description' => 'Simple kitchen remodel contract to avoid renovation management headaches.',
            'tags' => ['kitchen remodel', 'construction', 'renovation'],
            'popular' => true,
            'featured' => false
        ],
        [
            'id' => 27,
            'title' => 'Lump Sum Construction Contract',
            'category' => 'Construction',
            'description' => 'Construction contract for projects with a set fee arrangement.',
            'tags' => ['lump sum', 'construction', 'fixed price'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 28,
            'title' => 'Cost Plus Construction Contract',
            'category' => 'Construction',
            'description' => 'Contract ensuring parties recover costs after successful project completion.',
            'tags' => ['cost plus', 'construction', 'reimbursable'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 29,
            'title' => 'Fixed Price Construction Contract',
            'category' => 'Construction',
            'description' => 'Customize this contract to fit your construction project with fixed pricing.',
            'tags' => ['fixed price', 'construction', 'contract'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 30,
            'title' => 'Builders Contract',
            'category' => 'Construction',
            'description' => 'Perfect template covering all aspects and requirements of construction projects.',
            'tags' => ['builders', 'construction', 'general'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 31,
            'title' => 'Independent Truck Driver Contract',
            'category' => 'Transportation',
            'description' => 'Contract template for independent truck driver services and agreements.',
            'tags' => ['truck driver', 'transportation', 'independent'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 32,
            'title' => 'Event Decorator Contract',
            'category' => 'Events',
            'description' => 'Professional event decoration services contract template.',
            'tags' => ['event decorator', 'events', 'decoration'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 33,
            'title' => 'Teacher Contract Template',
            'category' => 'Education',
            'description' => 'Comprehensive teaching contract covering terms and educational responsibilities.',
            'tags' => ['teacher', 'education', 'academic'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 34,
            'title' => 'Talent Contract Template',
            'category' => 'Entertainment',
            'description' => 'Contract template for talent management and entertainment services.',
            'tags' => ['talent', 'entertainment', 'performance'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 35,
            'title' => 'Animation Contract Template',
            'category' => 'Creative',
            'description' => 'Professional animation services contract for creative projects.',
            'tags' => ['animation', 'creative', 'digital'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 36,
            'title' => 'Contract Extension Addendum',
            'category' => 'Legal',
            'description' => 'Template for extending existing contracts with additional terms.',
            'tags' => ['extension', 'addendum', 'legal'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 37,
            'title' => 'Soccer Contract Template',
            'category' => 'Sports',
            'description' => 'Professional soccer player contract template for sports organizations.',
            'tags' => ['soccer', 'sports', 'athlete'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 38,
            'title' => 'Technical Writer Contract',
            'category' => 'Writing',
            'description' => 'Contract template for technical writing services and documentation.',
            'tags' => ['technical writing', 'documentation', 'content'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 39,
            'title' => 'Artist Contract Template',
            'category' => 'Creative',
            'description' => 'Professional artist services contract for creative work and commissions.',
            'tags' => ['artist', 'creative', 'commission'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 40,
            'title' => 'Staffing Agency Contract',
            'category' => 'Employment',
            'description' => 'Contract template for staffing agency services and placements.',
            'tags' => ['staffing', 'agency', 'recruitment'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 41,
            'title' => 'Videography Contract',
            'category' => 'Creative',
            'description' => 'Professional videography services contract for video production.',
            'tags' => ['videography', 'video', 'production'],
            'popular' => true,
            'featured' => false
        ],
        [
            'id' => 42,
            'title' => 'Pet Sitting Contract',
            'category' => 'Animals',
            'description' => 'Contract template for pet sitting and animal care services.',
            'tags' => ['pet sitting', 'animals', 'care'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 43,
            'title' => 'Actor Contract Template',
            'category' => 'Entertainment',
            'description' => 'Professional acting contract for film, theater, and performance work.',
            'tags' => ['actor', 'entertainment', 'performance'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 44,
            'title' => 'Owner Financing Contract',
            'category' => 'Finance',
            'description' => 'Contract template for owner-financed real estate transactions.',
            'tags' => ['owner financing', 'real estate', 'finance'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 45,
            'title' => 'Woodworking Contract Template',
            'category' => 'Crafts',
            'description' => 'Contract for custom woodworking projects and carpentry services.',
            'tags' => ['woodworking', 'carpentry', 'crafts'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 46,
            'title' => 'Time and Materials Contract',
            'category' => 'Business',
            'description' => 'Contract template for time and materials based project billing.',
            'tags' => ['time and materials', 'billing', 'hourly'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 47,
            'title' => 'Social Media Management Contract',
            'category' => 'Marketing',
            'description' => 'Contract for social media management and digital marketing services.',
            'tags' => ['social media', 'marketing', 'digital'],
            'popular' => true,
            'featured' => false
        ],
        [
            'id' => 48,
            'title' => 'Translation Contract Template',
            'category' => 'Language',
            'description' => 'Professional translation services contract for language projects.',
            'tags' => ['translation', 'language', 'localization'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 49,
            'title' => 'Illustrator Contract Template',
            'category' => 'Creative',
            'description' => 'Contract template for illustration services and graphic design work.',
            'tags' => ['illustration', 'graphic design', 'creative'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 50,
            'title' => 'Makeup Artist Contract',
            'category' => 'Beauty',
            'description' => 'Professional makeup artist services contract for events and shoots.',
            'tags' => ['makeup artist', 'beauty', 'cosmetics'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 51,
            'title' => 'Contract Renewal Template',
            'category' => 'Legal',
            'description' => 'Template for renewing existing contracts with updated terms.',
            'tags' => ['renewal', 'extension', 'legal'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 52,
            'title' => 'Film Production Contract',
            'category' => 'Entertainment',
            'description' => 'Comprehensive contract for film and video production projects.',
            'tags' => ['film production', 'entertainment', 'media'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 53,
            'title' => 'Interpreter Contract',
            'category' => 'Language',
            'description' => 'Contract template for interpretation services and language support.',
            'tags' => ['interpreter', 'language', 'communication'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 54,
            'title' => 'Wedding Photography Contract',
            'category' => 'Creative',
            'description' => 'Specialized photography contract for wedding and event coverage.',
            'tags' => ['wedding photography', 'events', 'photography'],
            'popular' => true,
            'featured' => true
        ],
        [
            'id' => 55,
            'title' => 'Freelance Graphic Design Contract',
            'category' => 'Creative',
            'description' => 'Contract template for freelance graphic design projects and services.',
            'tags' => ['graphic design', 'freelance', 'creative'],
            'popular' => true,
            'featured' => false
        ],
        [
            'id' => 56,
            'title' => 'Music Producer Contract',
            'category' => 'Entertainment',
            'description' => 'Professional music production contract for recording and audio services.',
            'tags' => ['music producer', 'audio', 'entertainment'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 57,
            'title' => 'Outsourcing Services Contract',
            'category' => 'Business',
            'description' => 'Contract template for outsourcing business services and operations.',
            'tags' => ['outsourcing', 'business', 'services'],
            'popular' => true,
            'featured' => false
        ],
        [
            'id' => 58,
            'title' => 'Car Rental Agreement',
            'category' => 'Transportation',
            'description' => 'Vehicle rental contract for car rental and transportation services.',
            'tags' => ['car rental', 'vehicle', 'transportation'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 59,
            'title' => 'Software Development Agreement',
            'category' => 'Technology',
            'description' => 'Essential contract for software development and web design projects.',
            'tags' => ['software development', 'technology', 'programming'],
            'popular' => true,
            'featured' => true
        ],
        [
            'id' => 60,
            'title' => 'Joint Venture Agreement',
            'category' => 'Business',
            'description' => 'Establish contractual terms for business joint venture operations.',
            'tags' => ['joint venture', 'partnership', 'business'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 61,
            'title' => 'Investment Contract Template',
            'category' => 'Finance',
            'description' => 'Legal agreement protecting investor financial investment in companies.',
            'tags' => ['investment', 'finance', 'funding'],
            'popular' => true,
            'featured' => false
        ],
        [
            'id' => 62,
            'title' => 'Agency Agreement Template',
            'category' => 'Business',
            'description' => 'Contract to hire an agent to market or sell goods and services.',
            'tags' => ['agency', 'representation', 'sales'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 63,
            'title' => 'Car Sale Agreement',
            'category' => 'Transportation',
            'description' => 'Contract setting terms and conditions for vehicle sales transactions.',
            'tags' => ['car sale', 'vehicle', 'purchase'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 64,
            'title' => 'Payment Agreement Template',
            'category' => 'Finance',
            'description' => 'Create legally binding payment contracts with specified terms and schedules.',
            'tags' => ['payment', 'finance', 'installment'],
            'popular' => false,
            'featured' => false
        ],
        [
            'id' => 65,
            'title' => 'Studio Rental Agreement',
            'category' => 'Real Estate',
            'description' => 'Rental agreement template for studio spaces and creative facilities.',
            'tags' => ['studio rental', 'real estate', 'creative space'],
            'popular' => false,
            'featured' => false
        ]
    ];

    $categories = array_unique(array_column($templates, 'category'));
    sort($categories);
    ?>

    <div x-data="templateApp()" x-cloak>
        <!-- Header Section -->
        <div class="bg-white py-16">
            <div class="container mx-auto px-4 text-center">
                <h1 class="text-5xl font-bold text-gray-900 mb-8">Contract Templates</h1>
                
                <!-- Search Bar -->
                <div class="max-w-2xl mx-auto mb-8">
                    <div class="relative">
                        <input 
                            type="text" 
                            x-model="searchQuery"
                            placeholder="Search"
                            class="w-full pl-4 pr-12 py-4 text-lg border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                        >
                        <div class="absolute inset-y-0 right-0 pr-4 flex items-center pointer-events-none">
                            <svg class="h-6 w-6 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                            </svg>
                        </div>
                    </div>
                </div>
                
                <!-- Description Text -->
                <div class="max-w-4xl mx-auto">
                    <p class="text-lg text-gray-600 leading-relaxed">
                        From employment contracts to rental agreements, contracts are essential in nearly every business. But drawing up contracts from scratch every time you need one can be time-consuming. That's why we created a library of standard contract templates to help you save time and jumpstart your contract library.
                    </p>
                </div>
                
                <!-- Download Template Manager Button -->
                <div class="max-w-4xl mx-auto mt-8">
                    <button 
                        @click="downloadTemplate()"
                        class="inline-flex items-center px-6 py-3 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700 shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 transition-all duration-200"
                    >
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                        </svg>
                        Download Template Manager
                    </button>
                </div>
            </div>
        </div>

        <!-- Fixed Filter Bar for Mobile -->
        <div class="lg:hidden sticky top-0 bg-white border-b border-gray-200 shadow-sm z-30">
            <div class="container mx-auto px-4 py-4">
                <div class="flex items-center justify-between">
                    <h2 class="text-lg font-semibold text-gray-800">Filter Templates</h2>
                    <button 
                        @click="showMobileFilters = !showMobileFilters"
                        class="bg-gray-100 p-2 rounded-lg"
                    >
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707v4.586a1 1 0 01-.293.707L9 19.414V13.414a1 1 0 00-.293-.707L2.293 6.293A1 1 0 012 5.586V4z"></path>
                        </svg>
                    </button>
                </div>

                <!-- Mobile Filters -->
                <div 
                    x-show="showMobileFilters" 
                    x-transition
                    class="border-t border-gray-200 pt-4 mt-4"
                >
                    <div class="space-y-4">
                        <!-- Categories -->
                        <div>
                            <h3 class="font-medium text-gray-800 mb-2">Categories</h3>
                            <div class="grid grid-cols-2 gap-2">
                                <label class="flex items-center">
                                    <input 
                                        type="checkbox" 
                                        :checked="isCategorySelected('all')"
                                        @change="toggleCategory('all')"
                                        class="rounded border-gray-300 text-blue-600 focus:ring-blue-500"
                                    >
                                    <span class="ml-2 text-sm text-gray-700">All</span>
                                </label>
                                <?php foreach($categories as $category): ?>
                                <label class="flex items-center">
                                    <input 
                                        type="checkbox" 
                                        :checked="isCategorySelected('<?php echo $category; ?>')"
                                        @change="toggleCategory('<?php echo $category; ?>')"
                                        class="rounded border-gray-300 text-blue-600 focus:ring-blue-500"
                                    >
                                    <span class="ml-2 text-sm text-gray-700"><?php echo $category; ?></span>
                                </label>
                                <?php endforeach; ?>
                            </div>
                        </div>

                        <!-- Quick Filters -->
                        <div>
                            <h3 class="font-medium text-gray-800 mb-2">Filter by</h3>
                            <div class="flex flex-wrap gap-4">
                                <label class="flex items-center">
                                    <input 
                                        type="checkbox" 
                                        x-model="showPopularOnly"
                                        class="rounded border-gray-300 text-blue-600 focus:ring-blue-500"
                                    >
                                    <span class="ml-2 text-sm text-gray-700">Popular Only</span>
                                </label>
                                <label class="flex items-center">
                                    <input 
                                        type="checkbox" 
                                        x-model="showFeaturedOnly"
                                        class="rounded border-gray-300 text-blue-600 focus:ring-blue-500"
                                    >
                                    <span class="ml-2 text-sm text-gray-700">Featured Only</span>
                                </label>
                            </div>
                        </div>

                        <!-- Results Count -->
                        <div class="text-sm text-gray-500 pt-2 border-t border-gray-200">
                            Showing <span x-text="filteredTemplates.length"></span> templates
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content with Desktop Sidebar -->
        <div class="flex bg-gray-50">
            <!-- Desktop Sidebar -->
            <div class="hidden lg:block w-64 bg-white border-r border-t border-gray-200 sticky top-0 h-screen overflow-y-auto">
                <div class="p-6 border-b border-gray-200">
                    <h2 class="text-xl font-bold text-gray-800">Filter Templates</h2>
                    <p class="text-sm text-gray-600 mt-1">Narrow down your search</p>
                </div>
                
                <!-- Filters -->
                <div class="p-4">
                    <h3 class="font-semibold text-gray-800 mb-3">Categories</h3>
                    <div class="space-y-2">
                        <label class="flex items-center">
                            <input 
                                type="checkbox" 
                                :checked="isCategorySelected('all')"
                                @change="toggleCategory('all')"
                                class="rounded border-gray-300 text-blue-600 focus:ring-blue-500"
                            >
                            <span class="ml-2 text-sm text-gray-700">All Categories</span>
                        </label>
                        <?php foreach($categories as $category): ?>
                        <label class="flex items-center">
                            <input 
                                type="checkbox" 
                                :checked="isCategorySelected('<?php echo $category; ?>')"
                                @change="toggleCategory('<?php echo $category; ?>')"
                                class="rounded border-gray-300 text-blue-600 focus:ring-blue-500"
                            >
                            <span class="ml-2 text-sm text-gray-700"><?php echo $category; ?></span>
                        </label>
                        <?php endforeach; ?>
                    </div>

                    <h3 class="font-semibold text-gray-800 mb-3 mt-6">Filter by</h3>
                    <div class="space-y-2">
                        <label class="flex items-center">
                            <input 
                                type="checkbox" 
                                x-model="showPopularOnly"
                                class="rounded border-gray-300 text-blue-600 focus:ring-blue-500"
                            >
                            <span class="ml-2 text-sm text-gray-700">Popular Only</span>
                        </label>
                        <label class="flex items-center">
                            <input 
                                type="checkbox" 
                                x-model="showFeaturedOnly"
                                class="rounded border-gray-300 text-blue-600 focus:ring-blue-500"
                            >
                            <span class="ml-2 text-sm text-gray-700">Featured Only</span>
                        </label>
                    </div>

                    <!-- Results Count -->
                    <div class="mt-6 pt-4 border-t border-gray-200">
                        <div class="text-sm text-gray-500">
                            Showing <span x-text="filteredTemplates.length"></span> templates
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="flex-1 p-4 lg:p-8 bg-gray-50 border-t border-gray-200">
                <div class="max-w-5xl mx-auto">
                    <!-- Templates Grid -->
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
                        <template x-for="template in paginatedTemplates" :key="template.id">
                            <div class="bg-white rounded-lg border border-gray-200 hover:border-gray-300 hover:shadow-sm transition-all cursor-pointer" @click="openModal(template)">
                                <!-- Template Preview -->
                                <div class="h-64 bg-gradient-to-br rounded-t-lg p-6 flex items-center justify-center relative" :class="getCategoryColors(template.category)">
                                    <div class="text-center">
                                        <div class="w-16 h-24 bg-white rounded border border-gray-200 mx-auto mb-3 flex items-center justify-center">
                                            <svg class="w-8 h-8" :class="getCategoryIconColor(template.category)" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                                            </svg>
                                        </div>
                                        <div class="text-xs text-gray-500" x-text="template.category"></div>
                                    </div>
                                    <!-- Badges -->
                                    <div class="absolute top-3 right-3 flex flex-col space-y-1">
                                        <span x-show="template.popular" class="bg-yellow-100 text-yellow-800 text-xs px-2 py-1 rounded-full font-medium">Popular</span>
                                        <span x-show="template.featured" class="bg-blue-100 text-blue-800 text-xs px-2 py-1 rounded-full font-medium">Featured</span>
                                    </div>
                                </div>
                                
                                <!-- Template Info -->
                                <div class="p-4">
                                    <h3 class="font-semibold text-gray-900 mb-2 text-sm leading-tight" x-text="template.title"></h3>
                                    <p class="text-xs text-gray-600 mb-3 line-clamp-2" x-text="template.description"></p>
                                    <div class="flex flex-wrap gap-1">
                                        <template x-for="tag in template.tags.slice(0, 2)">
                                            <span class="bg-gray-100 text-gray-700 text-xs px-2 py-1 rounded" x-text="tag"></span>
                                        </template>
                                    </div>
                                </div>
                            </div>
                        </template>
                    </div>

                    <!-- Pagination -->
                    <div class="flex justify-center items-center space-x-2" x-show="totalPages > 1">
                        <button 
                            @click="currentPage = Math.max(1, currentPage - 1)"
                            :disabled="currentPage === 1"
                            class="px-3 py-2 rounded-md bg-white border border-gray-300 text-sm font-medium text-gray-500 hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed"
                        >
                            Previous
                        </button>
                        
                        <template x-for="page in Array.from({length: totalPages}, (_, i) => i + 1)">
                            <button 
                                @click="currentPage = page"
                                :class="currentPage === page ? 'bg-blue-600 text-white' : 'bg-white text-gray-500 hover:bg-gray-50'"
                                class="px-3 py-2 rounded-md border border-gray-300 text-sm font-medium"
                                x-text="page"
                            ></button>
                        </template>
                        
                        <button 
                            @click="currentPage = Math.min(totalPages, currentPage + 1)"
                            :disabled="currentPage === totalPages"
                            class="px-3 py-2 rounded-md bg-white border border-gray-300 text-sm font-medium text-gray-500 hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed"
                        >
                            Next
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal -->
        <div x-show="showModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50" @click.self="closeModal()">
            <div class="bg-white rounded-lg max-w-2xl w-full max-h-[90vh] overflow-y-auto">
                <div class="p-6 border-b">
                    <div class="flex justify-between items-start">
                        <div>
                            <h2 class="text-2xl font-bold text-gray-900" x-text="selectedTemplate?.title"></h2>
                            <p class="text-gray-600 mt-1" x-text="selectedTemplate?.category"></p>
                        </div>
                        <button @click="closeModal()" class="text-gray-400 hover:text-gray-600">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                            </svg>
                        </button>
                    </div>
                </div>
                
                <div class="p-6">
                    <!-- Template Preview -->
                    <div class="bg-gray-50 rounded-lg p-6 mb-6">
                        <div class="bg-white rounded shadow-sm p-4 min-h-[300px]">
                            <div class="border-b pb-4 mb-4">
                                <h3 class="font-bold text-lg" x-text="selectedTemplate?.title"></h3>
                                <p class="text-sm text-gray-600">Template Preview</p>
                            </div>
                            <div class="space-y-3 text-sm">
                                <div class="flex justify-between">
                                    <span class="font-medium">Party 1:</span>
                                    <span class="text-gray-600">[Company Name]</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="font-medium">Party 2:</span>
                                    <span class="text-gray-600">[Client Name]</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="font-medium">Date:</span>
                                    <span class="text-gray-600">[Contract Date]</span>
                                </div>
                                <div class="mt-4 pt-4 border-t">
                                    <p class="text-gray-700">This agreement outlines the terms and conditions...</p>
                                    <p class="text-gray-500 mt-2">[Template content continues...]</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="mb-6">
                        <h3 class="font-semibold text-gray-900 mb-2">Description</h3>
                        <p class="text-gray-600" x-text="selectedTemplate?.description"></p>
                    </div>
                    
                    <div class="mb-6">
                        <h3 class="font-semibold text-gray-900 mb-2">Tags</h3>
                        <div class="flex flex-wrap gap-2">
                            <template x-for="tag in selectedTemplate?.tags || []">
                                <span class="bg-blue-100 text-blue-800 text-sm px-3 py-1 rounded-full" x-text="tag"></span>
                            </template>
                        </div>
                    </div>
                    
                    <div class="flex space-x-4">
                        <button 
                            @click="downloadTemplate()"
                            class="flex-1 bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors font-medium inline-flex items-center justify-center"
                        >
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                            </svg>
                            Download Template Manager
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Success Modal -->
        <div x-show="showSuccessModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50" @click.self="closeSuccessModal()">
            <div class="bg-white rounded-lg max-w-md w-full">
                <div class="p-6 text-center">
                    <!-- Success Icon -->
                    <div class="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-green-100 mb-4">
                        <svg class="h-8 w-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                        </svg>
                    </div>
                    
                    <!-- Success Title -->
                    <h3 class="text-lg font-semibold text-gray-900 mb-2">Download Started!</h3>
                    
                    <!-- Success Message -->
                    <p class="text-gray-600 mb-6">
                        Template Manager download has started successfully. This program will help you fill and customize your contract templates with ease.
                    </p>
                    
                    <!-- Features List -->
                    <div class="text-left bg-gray-50 rounded-lg p-4 mb-6">
                        <h4 class="font-medium text-gray-900 mb-2">What you can do with Template Manager:</h4>
                        <ul class="text-sm text-gray-600 space-y-1">
                            <li>• Fill templates with your information</li>
                            <li>• Customize contract terms and conditions</li>
                            <li>• Save and reuse your templates</li>
                            <li>• Export to PDF or Word formats</li>
                        </ul>
                    </div>
                    
                    <!-- Close Button -->
                    <button 
                        @click="closeSuccessModal()"
                        class="w-full bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors font-medium"
                    >
                        Got it!
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function templateApp() {
            return {
                templates: <?php echo json_encode($templates); ?>,
                searchQuery: '',
                selectedCategories: ['all'],
                showPopularOnly: false,
                showFeaturedOnly: false,
                currentPage: 1,
                itemsPerPage: 9,
                showModal: false,
                selectedTemplate: null,
                showMobileFilters: false,
                showSuccessModal: false,

                // URL persistence methods
                getUrlParams() {
                    const params = new URLSearchParams(window.location.search);
                    return {
                        search: params.get('search') || '',
                        categories: params.get('categories') ? params.get('categories').split(',') : ['all'],
                        popular: params.get('popular') === 'true',
                        featured: params.get('featured') === 'true',
                        page: parseInt(params.get('page')) || 1
                    };
                },

                updateUrl() {
                    const params = new URLSearchParams();
                    
                    // Add search parameter
                    if (this.searchQuery) {
                        params.set('search', this.searchQuery);
                    }
                    
                    // Add categories parameter
                    if (!this.selectedCategories.includes('all') && this.selectedCategories.length > 0) {
                        params.set('categories', this.selectedCategories.join(','));
                    }
                    
                    // Add popular filter
                    if (this.showPopularOnly) {
                        params.set('popular', 'true');
                    }
                    
                    // Add featured filter
                    if (this.showFeaturedOnly) {
                        params.set('featured', 'true');
                    }
                    
                    // Add page parameter
                    if (this.currentPage > 1) {
                        params.set('page', this.currentPage.toString());
                    }
                    
                    // Update URL without page reload
                    const newUrl = params.toString() ? 
                        `${window.location.pathname}?${params.toString()}` : 
                        window.location.pathname;
                    
                    window.history.replaceState({}, '', newUrl);
                },

                loadFromUrl() {
                    const urlParams = this.getUrlParams();
                    
                    this.searchQuery = urlParams.search;
                    this.selectedCategories = urlParams.categories;
                    this.showPopularOnly = urlParams.popular;
                    this.showFeaturedOnly = urlParams.featured;
                    this.currentPage = urlParams.page;
                    
                    // Validate page number against actual results
                    this.$nextTick(() => {
                        if (this.currentPage > this.totalPages && this.totalPages > 0) {
                            this.currentPage = 1;
                        }
                    });
                },

                getCategoryColors(category) {
                    const colorMap = {
                        'Employment': 'from-blue-50 to-blue-100',
                        'Legal': 'from-purple-50 to-purple-100',
                        'Consulting': 'from-green-50 to-green-100',
                        'Business': 'from-orange-50 to-orange-100',
                        'Real Estate': 'from-teal-50 to-teal-100',
                        'Creative': 'from-pink-50 to-pink-100',
                        'Construction': 'from-yellow-50 to-yellow-100',
                        'Sales': 'from-red-50 to-red-100',
                        'Technology': 'from-indigo-50 to-indigo-100',
                        'Events': 'from-rose-50 to-rose-100',
                        'Marketing': 'from-cyan-50 to-cyan-100'
                    };
                    return colorMap[category] || 'from-gray-50 to-gray-100';
                },

                getCategoryIconColor(category) {
                    const colorMap = {
                        'Employment': 'text-blue-600',
                        'Legal': 'text-purple-600',
                        'Consulting': 'text-green-600',
                        'Business': 'text-orange-600',
                        'Real Estate': 'text-teal-600',
                        'Creative': 'text-pink-600',
                        'Construction': 'text-yellow-600',
                        'Sales': 'text-red-600',
                        'Technology': 'text-indigo-600',
                        'Events': 'text-rose-600',
                        'Marketing': 'text-cyan-600'
                    };
                    return colorMap[category] || 'text-gray-600';
                },

                get filteredTemplates() {
                    let filtered = this.templates;

                    // Search filter
                    if (this.searchQuery) {
                        const query = this.searchQuery.toLowerCase();
                        filtered = filtered.filter(template => 
                            template.title.toLowerCase().includes(query) ||
                            template.description.toLowerCase().includes(query) ||
                            template.category.toLowerCase().includes(query) ||
                            template.tags.some(tag => tag.toLowerCase().includes(query))
                        );
                    }

                    // Category filter
                    if (!this.selectedCategories.includes('all') && this.selectedCategories.length > 0) {
                        filtered = filtered.filter(template => 
                            this.selectedCategories.includes(template.category)
                        );
                    }

                    // Popular filter
                    if (this.showPopularOnly) {
                        filtered = filtered.filter(template => template.popular);
                    }

                    // Featured filter
                    if (this.showFeaturedOnly) {
                        filtered = filtered.filter(template => template.featured);
                    }

                    return filtered;
                },

                get totalPages() {
                    return Math.ceil(this.filteredTemplates.length / this.itemsPerPage);
                },

                get paginatedTemplates() {
                    const start = (this.currentPage - 1) * this.itemsPerPage;
                    const end = start + this.itemsPerPage;
                    return this.filteredTemplates.slice(start, end);
                },

                openModal(template) {
                    this.selectedTemplate = template;
                    this.showModal = true;
                    document.body.style.overflow = 'hidden';
                },

                closeModal() {
                    this.showModal = false;
                    this.selectedTemplate = null;
                    document.body.style.overflow = 'auto';
                },

                downloadTemplate() {
                    // Simulate download of template manager
                    const link = document.createElement('a');
                    link.href = '/web/template-manager.php';
                    link.download = 'ContractTemplateManager.exe';
                    link.click();
                    
                    // Show success modal
                    this.showSuccessModal = true;
                },

                toggleCategory(category) {
                    if (category === 'all') {
                        // If "All Categories" is selected, clear all other categories
                        this.selectedCategories = ['all'];
                    } else {
                        // If a specific category is selected
                        if (this.selectedCategories.includes(category)) {
                            // Remove the category
                            this.selectedCategories = this.selectedCategories.filter(cat => cat !== category);
                            // If no categories are selected, default to "all"
                            if (this.selectedCategories.length === 0 || (this.selectedCategories.length === 1 && this.selectedCategories[0] === 'all')) {
                                this.selectedCategories = ['all'];
                            }
                        } else {
                            // Add the category and remove "all"
                            this.selectedCategories = this.selectedCategories.filter(cat => cat !== 'all');
                            this.selectedCategories.push(category);
                        }
                    }
                },

                isCategorySelected(category) {
                    return this.selectedCategories.includes(category);
                },

                init() {
                    // Load state from URL on initialization
                    this.loadFromUrl();
                    
                    // Watch for changes and update URL
                    this.$watch('searchQuery', () => {
                        this.currentPage = 1;
                        this.updateUrl();
                    });
                    
                    this.$watch('selectedCategories', () => {
                        this.currentPage = 1;
                        this.updateUrl();
                    });
                    
                    this.$watch('showPopularOnly', () => {
                        this.currentPage = 1;
                        this.updateUrl();
                    });
                    
                    this.$watch('showFeaturedOnly', () => {
                        this.currentPage = 1;
                        this.updateUrl();
                    });
                    
                    this.$watch('currentPage', () => {
                        this.updateUrl();
                    });

                    // Handle browser back/forward buttons
                    window.addEventListener('popstate', () => {
                        this.loadFromUrl();
                    });
                },

                closeSuccessModal() {
                    this.showSuccessModal = false;
                }
            }
        }
    </script>
</body>
</html>
