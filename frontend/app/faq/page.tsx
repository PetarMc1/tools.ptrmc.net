import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Petar_mc's Tools | FAQ",
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
  const lastUpdated = "2026-05-20";

    const faqItems: FaqItem[] = [
    {
        id: "what-is-this-site",
        question: "What is tools.ptrmc.net?",
        answer:
        "tools.ptrmc.net is a collection of free developer tools for working with APIs, packages, feeds, and other.",
    },
    {
        id: "who-is-this-for",
        question: "Who is this for?",
        answer:
        "The tools are mainly built for developers and automation workflows, but anyone can use them.",
    },
    {
        id: "is-it-free",
        question: "Are the tools free to use?",
        answer:
        "Yes. The public tools are free to use.",
    },
    {
        id: "do-you-store-data",
        question: "Do you store uploaded files or API data?",
        answer:
        "Most tools process data temporarily in memory and do not permanently store uploaded content unless explicitly stated.",
    },
    {
        id: "rate-limits",
        question: "Are there rate limits?",
        answer:
        "Yes. Abuse protection and rate limits may be applied to keep the services stable for everyone.",
    },
    {
        id: "can-i-be-blocked",
        question: "Can I get banned or blocked?",
        answer:
        "Yes. Excessive abuse, spam, scraping, or attempts to disrupt the services may result in temporary or permanent blocking.",
    },
    {
        id: "open-source",
        question: "Are the tools open source?",
        answer:
        "Yes. The project is available at https://github.com/PetarMc1/tools.ptrmc.net",
    },
    {
        id: "bug-reports",
        question: "What should I do if something breaks?",
        answer:
        "If you find a bug or a broken feature, report it through the project repository or contact page.",
    },
    {
        id: "api-access",
        question: "Can I use these tools programmatically?",
        answer:
        "Some tools expose APIs or can be integrated into scripts and automation workflows depending on the service.",
    },
    {
        id: "self-hosting",
        question: "Can I self-host these tools?",
        answer:
        "Yes the site is fully self-hosteble. A guide on how to do it check the GitHub repo.",
    },
    ];

  const filteredItems = faqItems;

  return (
    <section className="card static-page" aria-labelledby="faq-title">
      <h2 id="faq-title" className="static-page_title">
        FAQ
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