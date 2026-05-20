import type { Metadata } from "next";
import "./globals.css";
import Header from "@/components/Header";
import Footer from "@/components/Footer";

export const metadata: Metadata = {
  description:
    "Explore a collection of free developer tools, APIs, utilities and resources created by PetarMc1 to help developers build, test, automate and improve their projects",

  keywords: [
    "developer tools",
    "APIs",
    "utilities",
    "programming tools",
    "JSON tools",
    "developer resources",
    "automation tools",
    "web development",
    "backend tools",
    "frontend tools",
    "PetarMc1",
  ],

  robots: "index, follow",

  openGraph: {
    title: "Petar_mc's Tools",
    description:
      "Explore a collection of free developer tools, APIs, utilities and resources created by PetarMc1",
    type: "website",
    url: "https://tools.ptrmc.net",
    siteName: "Petar_mc's Tools",
  },

  twitter: {
    card: "summary",
    title: "Petar_mc's Tools",
    description:
      "Explore a collection of free developer tools, APIs, utilities and resources created by PetarMc1",
  },

  alternates: {
    canonical: "https://tools.ptrmc.net",
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
return (
    <html lang="en">
      <body>
        <Header/>
        <div className="app">{children}</div>
        <Footer/>
      </body>
    </html>
  );
}
