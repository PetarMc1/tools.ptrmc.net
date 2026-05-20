import type { Metadata } from "next";

export const metadata: Metadata = {
	title: "Petar_mc's Tools | Contact",
	robots: "noindex, nofollow"
};

export default function ContactPage() {
	return (
		<section className="card static-page" aria-labelledby="contact-title">
            <h2 id="contact-title" className="static-page_title">
				Bug Reports and Issues
			</h2>
            
            <p className="static-page_description">
				Report bugs at the issues section in the {" "}
                 <a className="text-blue-600" href="https://github.com/PetarMc1/tools.ptrmc.net/issues">Github Repo</a> issues section
			</p>

			<h2 id="contact-title" className="static-page_title">
				Contact
			</h2>

			<p className="static-page_description">
				Have a question, bug report or feedback? Feel free to reach out to me via email on: <b className="text-blue-600">tools[at]ptrmc.net</b> <br />
				I am always happy to hear from users and will do my best to respond as quickly as possible.
			</p>
		</section>
	);
}
