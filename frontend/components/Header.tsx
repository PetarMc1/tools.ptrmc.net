'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';

export default function Header() {
  const route = usePathname();

  return (
    <header className="app-header">
      <div className="header-top">
        <h1 className="app-title">Petar_mc's Tools</h1>
      </div>

      <p className="app-subtitle" />

      <nav className="top-nav" aria-label="Primary navigation">
        <Link
          className={`top-nav_link ${route === '/' ? 'top-nav_link-active' : ''}`}
          href="/"
        >
          Home
        </Link>

        <Link
          className={`top-nav_link ${
            route.startsWith('/terms') ? 'top-nav_link-active' : ''
          }`}
          href="/terms"
        >
          Terms of Service
        </Link>

        <Link
          className={`top-nav_link ${
            route.startsWith('/faq') ? 'top-nav_link-active' : ''
          }`}
          href="/faq"
        >
          FAQ
        </Link>

         <Link
          className={`top-nav_link ${
            route.startsWith('/contact') ? 'top-nav_link-active' : ''
          }`}
          href="/contact"
        >
          Contact
        </Link>

        <Link
          className={`top-nav_link ${route === '/api-docs' ? 'top-nav_link-active' : ''}`}
          href="/api-docs"
          target="_blank"
        >
          API Docs
        </Link>
      </nav>
    </header>
  );
}