import Link from 'next/link';

export default function Footer() {
  const currentYear = new Date().getFullYear();

  return (
    <footer className="app-footer">
      <div className="app-footer_links">
        <Link href="/">Home</Link>

        <span aria-hidden="true">•</span>

        <Link href="/contact">Contact</Link>

        <span aria-hidden="true">•</span>

        <Link href="/api-docs" target="_blank">
          API Docs
        </Link>
      </div>

      <p className="app-footer_legal">
        Copyright © {currentYear}{' '}
        <a
          href="https://github.com/PetarMc1"
          target="_blank"
          rel="noopener noreferrer"
        >
          PetarMc1
        </a>
      </p>
    </footer>
  );
}