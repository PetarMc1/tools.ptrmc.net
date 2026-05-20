import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "GitRSS | FAQ",
  robots: "noindex, nofollow",
  alternates: {
    canonical: "https://tools.ptrmc.net/faq/gitrss",
  },
};

type FaqItem = {
  id: string;
  question: string;
  answer: string;
};

export default function GitRSSFaqPage() {
  const lastUpdated = "2026-04-26";

  const faqItems: FaqItem[] = [
    {
      id: "what-is-this-app",
      question: "What is this app?",
      answer:
        "A GitHub RSS feed generator that converts repositories into RSS feeds.",
    },
    {
      id: "how-fresh-is-data",
      question: "How fresh is the data?",
      answer:
        "Data is cached and may be delayed depending on system load and rate limits.",
    },
    {
      id: "why-not-realtime",
      question: "Why is data sometimes not real-time?",
      answer: "Due to GitHub API rate limits and caching layers.",
    },
    {
      id: "why-updates-late",
      question: "Why do some updates appear late?",
      answer: "Deep cache pages are refreshed periodically, not instantly.",
    },
    {
      id: "can-i-be-blocked",
      question: "Can I get banned or blocked?",
      answer: "Yes, access may be restricted at any time.",
    },
    {
      id: "official-github-product",
      question: "Is this an official GitHub product?",
      answer: "No, this project is not affiliated with GitHub.",
    },
  ];

  const filteredItems = faqItems;

  return (
    <section className="card static-page" aria-labelledby="faq-title">
      <h2 id="faq-title" className="static-page_title">
        GitRSS FAQ
      </h2>

      <p className="static-page_updated">
        Last updated: {lastUpdated}
      </p>

      <div className="faq-list">
        {filteredItems.map((item) => (
          <details key={item.id} className="faq-item">
            <summary>{item.question}</summary>
            <p>{item.answer}</p>
          </details>
        ))}
      </div>
    </section>
  );
}