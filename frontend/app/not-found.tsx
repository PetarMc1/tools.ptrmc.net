import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Petar_mc's Tools | 404 Not Found",
};

export default function NotFound() {
  return (
    <main className="app-main">
      <section className="card static-page">
        <h2 className="static-page_title">404 - Page Not Found</h2>

        <p className="static-page_description">
          The page you are looking for does not exist or has been moved.
        </p>

        <ul className="tools-list">
          <li className="tools-list_item">
            <a className="tool-card" href="/">
              <strong>Go Home</strong>
              <span className="tool-desc">
                Return to the list of available tools.
              </span>
            </a>
          </li>

        </ul>
      </section>

      <section className="card static-page">
        <h2 className="static-page_title">
          Looking for something else?
        </h2>

        <p className="static-page_description">
          The route you tried to access doesn’t match any available tool or page.
          Double-check the URL or return to the homepage to continue browsing.
        </p>
      </section>
    </main>
  );
}