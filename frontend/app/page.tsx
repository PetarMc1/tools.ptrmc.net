import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Petar_mc's Tools | Home",
};
export default function Home() {
  return (
    <main className="app-main">
      <section className="card static-page">
        <h2 className="static-page_title">Available Tools</h2>

        <p className="static-page_description">
          Explore the various tools available.
        </p>

        <ul className="tools-list">
          <li className="tools-list_item">
            <a className="tool-card" href="/gitrss" target="_blank" rel="noopener noreferrer">
              <strong>GitRSS</strong>
              <span className="tool-desc">
                Generate RSS feeds from GitHub activity.
              </span>
            </a>
          </li>

          <li className="tools-list_item">
            <a className="tool-card" href="/package-json-analyzer" target="_blank" rel="noopener noreferrer">
              <strong>Package JSON Analyzer</strong>
              <span className="tool-desc">
                Analyze package.json files.
              </span>
            </a>
          </li>

          <li className="tools-list_item">
            <a className="tool-card" href="/openapi-merger" target="_blank" rel="noopener noreferrer">
              <strong>OpenAPI Merger</strong>
              <span className="tool-desc">
                Merge and preview OpenAPI/Swagger specs.
              </span>
            </a>
          </li>
        </ul>
      </section>

      <section className="card static-page">
        <h2 className="static-page_title">
          Looking for the old tools.petarmc.com?
        </h2>

        <p className="static-page_description">
          The old tools.petarmc.com has been deprecated and is no longer available.
          Please use the new tools on this platform.
          <br /><br />
          The tools on the old site will not be migrated.
        </p>
      </section>
    </main>
  );
}