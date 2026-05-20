import Link from "next/link";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "GitRSS | Terms",
  robots: "noindex, nofollow",
  alternates: {
    canonical: "https://tools.ptrmc.net/terms/gitrss",
  },
};

export default function GitRSSTermsPage() {
  const lastUpdated = "2026-04-26";

  type TermsSection = {
    id: string;
    title: string;
    body: string;
  };

  const termsSection: TermsSection[] = [
    {
      id: "api-and-cache-behavior",
      title: "API & Cache Behavior",
      body: "API behavior, caching logic, synchronization timing, refresh intervals, and update frequency may change at any time without prior notice.",
    },
    {
      id: "github-rate-limits",
      title: "GitHub Rate Limits",
      body: "GitHub API rate limits and restrictions may delay, limit, or prevent updates, synchronization, or responses.",
    },
    {
      id: "data-freshness",
      title: "Data Freshness",
      body: "Data freshness, accuracy, completeness, and real-time availability are not guaranteed. Delays, stale responses, or partial data may occur.",
    },
    {
      id: "external-dependencies",
      title: "External Dependencies",
      body: "The service depends on third-party services including the GitHub API. Availability or performance issues affecting external services may impact functionality.",
    },
    {
      id: "cached-responses",
      title: "Cached Responses",
      body: "Cached or previously synchronized data may be served instead of live data at any time for performance, stability, or rate-limit management purposes.",
    },
    {
      id: "availability",
      title: "Availability",
      body: "No guarantee is made regarding uptime, uninterrupted availability, response times, or continuous operation of the service.",
    },
  ];

  return (
    <section className="card static-page" aria-labelledby="terms-title">
      <h2 id="terms-title" className="static-page_title">
        Terms of Service for GitRSS
      </h2>

      <p className="static-page_updated">
        Last updated: {lastUpdated}
      </p>

      <ol className="terms-list">
        {termsSection.map((section) => (
          <li key={section.id}>
            <h3>{section.title}</h3>
            <p>{section.body}</p>
          </li>
        ))}
      </ol>

      <p>
        By using the service, you acknowledge and accept these and the{" "}
        <Link href="/terms" className="terms-link">
          main
        </Link>{" "}
        terms and conditions.
      </p>
    </section>
  );
}