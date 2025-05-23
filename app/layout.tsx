import { GeistSans } from 'geist/font/sans';
import { NuqsAdapter } from 'nuqs/adapters/next/app';

import { PropsWithChildren, Suspense } from 'react';

import type { Metadata } from 'next';

import './globals.css';

export const metadata: Metadata = {
  title: {
    default: 'Contract Management Hub | Expert Insights & Resources',
    template: '%s | Contract Management Hub',
  },
  description:
    'Your comprehensive resource for contract management insights, best practices, and expert guidance. Learn about contract types, GDPR compliance, legal agreements, and modern contract lifecycle management.',
  keywords: [
    'contract management',
    'legal agreements',
    'contract lifecycle management',
    'GDPR compliance',
    'contract analytics',
    'business contracts',
    'contract automation',
    'legal technology',
    'contract risk management',
    'artificial intelligence contracts',
  ],
  authors: [{ name: 'Contract Management Hub' }],
  creator: 'Contract Management Hub',
  publisher: 'Contract Management Hub',
  formatDetection: {
    email: false,
    address: false,
    telephone: false,
  },
  metadataBase: new URL('https://contractdatahub.tech/'),
  icons: {
    icon: [
      { url: '/favicon/favicon.ico', sizes: '16x16 32x32 48x48' },
      { url: '/favicon/favicon.svg', type: 'image/svg+xml' },
      { url: '/favicon/favicon-96x96.png', sizes: '96x96', type: 'image/png' },
    ],
    apple: [
      {
        url: '/favicon/apple-touch-icon.png',
        sizes: '180x180',
        type: 'image/png',
      },
    ],
    other: [
      {
        rel: 'icon',
        url: '/favicon/web-app-manifest-192x192.png',
        sizes: '192x192',
        type: 'image/png',
      },
      {
        rel: 'icon',
        url: '/favicon/web-app-manifest-512x512.png',
        sizes: '512x512',
        type: 'image/png',
      },
    ],
  },
  openGraph: {
    type: 'website',
    locale: 'en_US',
    title: 'Contract Management Hub | Expert Insights & Resources',
    description:
      'Your comprehensive resource for contract management insights, best practices, and expert guidance. Learn about contract types, GDPR compliance, legal agreements, and modern contract lifecycle management.',
    siteName: 'Contract Management Hub',
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Contract Management Hub | Expert Insights & Resources',
    description:
      'Your comprehensive resource for contract management insights, best practices, and expert guidance. Learn about contract types, GDPR compliance, legal agreements, and modern contract lifecycle management.',
    creator: '@contracthub', // Replace with your actual Twitter handle
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      'max-video-preview': -1,
      'max-image-preview': 'large',
      'max-snippet': -1,
    },
  },
  verification: {
    // Add your verification codes here when available
    // google: 'your-google-verification-code',
    // yandex: 'your-yandex-verification-code',
    // yahoo: 'your-yahoo-verification-code',
  },
  manifest: '/manifest.json',
};

export default function RootLayout({ children }: PropsWithChildren) {
  return (
    <html lang='en'>
      <body className={GeistSans.className}>
        <NuqsAdapter>
          <Suspense>{children}</Suspense>
        </NuqsAdapter>
      </body>
    </html>
  );
}
