/** @type {import('next').NextConfig} */
const config = {
  compress: true,
  poweredByHeader: false,
  eslint: { ignoreDuringBuilds: true },
  typescript: { ignoreBuildErrors: true },
};

export default config;
