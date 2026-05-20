import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "OpenAPI JSON Merger | FAQ",
  robots: "noindex, nofollow",
  alternates: {
    canonical: "https://tools.ptrmc.net/faq/openapi-merger",
  },
};

type FaqItem = {
  id: string;
  question: string;
  answer: string;
};

export default function OpenapiMergerFaqPage() {
  const lastUpdated = "2026-04-26";

  const faqItems: FaqItem[] = [
    {
      id: "input-modes",
      question: "How can I add specs?",
      answer:
        "Use file upload, raw JSON paste, GitHub raw links, or direct URLs in a single merge request.",
    },
    {
      id: "conflicts",
      question: "How are conflicts handled?",
      answer:
        "Conflicts are reported as warnings, including duplicate paths, schema collisions, and incompatible operations.",
    },
    {
      id: "schema-collision",
      question: "What happens with schema name collisions?",
      answer:
        "Colliding schemas are auto-renamed with a document suffix and all matching $ref values are updated.",
    },
    {
      id: "storage",
      question: "Are my specs stored on the server?",
      answer:
        "No persistence is applied by default. Documents are processed in-memory for merge and returned in the response.",
    },
  ];

  const filteredItems = faqItems;

  return (
    <section className="card static-page" aria-labelledby="faq-title">
      <h2 id="faq-title" className="static-page_title">
        OpenAPI JSON Merger FAQ
      </h2>

      <p className="static-page_updated">Last updated: {lastUpdated}</p>

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
