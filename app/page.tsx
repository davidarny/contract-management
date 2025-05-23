import { ContentSection } from '@/components/home/content-section';
import { CTASection } from '@/components/home/cta-section';
import { HeroSection } from '@/components/home/hero-section';
import { Introduction } from '@/components/home/introduction';
import { JumpTo } from '@/components/home/jump-to';

// Define sections for the Jump To navigation
const sections = [
  { id: 'what-defines', title: 'What defines a contract?' },
  { id: 'key-elements', title: 'What are the key elements of a contract?' },
  { id: 'types', title: 'What are the different types of contracts?' },
  {
    id: 'differences',
    title: 'The differences between a contract and an agreement',
  },
  { id: 'breach', title: 'What constitutes a breach of contract?' },
  { id: 'final-words', title: 'Final words' },
];

export default function HomePage() {
  return (
    <div className='flex min-h-screen flex-col'>
      {/* Hero Section */}
      <HeroSection />

      {/* Blue Divider */}
      <div className='h-2 w-full bg-blue-800'></div>

      {/* Main Content */}
      <main id='main-content' className='container mx-auto px-4 py-12 md:px-6'>
        <div className='mx-auto max-w-4xl'>
          <Introduction />

          {/* Explore Articles Section (above Jump To) */}
          <CTASection />

          {/* Jump To Section */}
          <JumpTo sections={sections} />

          {/* What defines a contract? */}
          <ContentSection id='what-defines' title='What defines a contract?'>
            <p className='mb-4 text-gray-700'>
              A contract is a formal, legally binding agreement: an agreement
              between parties, creating mutual obligations that are enforceable
              by law. Legal professionals must ensure that the contracts they
              draft are not only well-constructed but also form an enforceable
              contract&mdash;a formal, legally binding agreement. Understanding
              the nuances of a written contract is crucial in this process.
            </p>
            <p className='mb-4 text-gray-700'>
              Several basic elements must be present to create a valid and
              enforceable agreement at the heart of any contract. Mutual assent,
              expressed through a valid offer and acceptance, lies at the
              foundation. Both parties must clearly understand and agree to the
              terms outlined in the contract. Additionally, consideration, or
              something of value exchanged between the parties, must be present
              to support the contract&apos;s validity. Moreover, legality and
              the capacity of the parties involved are essential components to
              consider.
            </p>
            <p className='mb-4 text-gray-700'>
              In the United States, most contracts are governed by a combination
              of common law and statutory law within the states where they are
              applied. While certain aspects of contract law may vary from state
              to state, there exists a substantial degree of consistency across
              the country. However, it&apos;s important to note that private
              agreements between non-governmental parties can sometimes
              supersede statutory rules and common law precedents.
            </p>
            <p className='mb-4 text-gray-700'>
              The significance of contracts extends across various facets of
              life. In real estate, contracts are pivotal in transactions such
              as buying or selling a home, outlining the terms and conditions of
              the agreement between the buyer and seller. Similarly, contracts
              play a crucial role in commercial transactions spanning different
              sectors, ensuring that parties fulfill their respective
              obligations.
            </p>
            <p className='mb-4 text-gray-700'>
              Whether it&apos;s the sale of goods, the provision of services, or
              the execution of business agreements, contract law governs a
              diverse array of activities. From everyday consumer transactions
              to complex business deals, the intricacies of contract law shape
              the legal landscape and provide the framework for facilitating
              agreements between parties. Understanding and navigating the
              complexities of contract law are essential for legal professionals
              to effectively advocate for their clients and uphold the integrity
              of contractual relationships in society.&quot;
            </p>
            <p className='mb-4 text-gray-700'>
              Among some common examples of areas where contracts are generally
              deployed are:
            </p>
            <ul className='mb-4 list-disc space-y-1 pl-6'>
              <li className='text-gray-700'>Lease and mortgage agreements</li>
              <li className='text-gray-700'>
                Sign-up agreements and online purchases
              </li>
              <li className='text-gray-700'>Employment contracts</li>
              <li className='text-gray-700'>Insurance agreements</li>
              <li className='text-gray-700'>Promissory notes</li>
            </ul>
            <p className='mb-4 text-gray-700'>
              Contracts have significant influence over individuals and entities
              across public and private domains, shaping their actions and
              interactions. In both personal and financial realms, the notion of
              mutually beneficial agreements, sanctioned by legal frameworks,
              underpins numerous relationships. Therefore, the clarity and
              precision with which contracts are drafted are paramount.
            </p>
            <p className='text-gray-700'>
              To optimize the drafting and execution of contracts, legal
              professionals often turn to various tools and solutions tailored
              for contract lifecycle management or drafting. These tools offer
              efficient avenues for exploring the intricate components of
              existing contracts, enhancing the drafting process.
            </p>
          </ContentSection>

          {/* Key Elements */}
          <ContentSection
            id='key-elements'
            title='What are the key elements of a contract?'
          >
            <p className='mb-4 text-gray-700'>
              While contracts themselves cover an enormous array of legal areas,
              they do share a remarkable amount in common across industry and
              type. To that end, several key elements constitute contract
              formation; contract law is shaped by considerations of public
              policy, and parties involved, such as the offeror, must be aware
              of these legal principles. Those elements are offer,
              consideration, acceptance, and mutuality.
            </p>

            <div className='mb-4'>
              <h3 className='mb-2 text-xl font-semibold text-gray-800'>
                Offer
              </h3>
              <p className='text-gray-700'>
                The offer, explains the educational center, involves one party
                promising to do something, or conversely, promising to refrain
                from doing a particular action.
              </p>
            </div>

            <div className='mb-4'>
              <h3 className='mb-2 text-xl font-semibold text-gray-800'>
                Consideration
              </h3>
              <p className='mb-2 text-gray-700'>
                Consideration, it adds, is when something of value is offered in
                exchange for the above-stated action or inaction.
              </p>
              <p className='mb-2 text-gray-700'>
                &quot;This can take the form of a significant expenditure of
                money or effort, a promise to perform some service, an agreement
                not to do something or reliance on the promise. Consideration is
                the value that induces the parties to enter into the
                contract,&quot; reads information from the university.
              </p>
              <p className='text-gray-700'>
                As such, the mere presence of that consideration is what
                separates a contract from that of a &quot;gift.&quot; In the
                legal sense of the word, a gift is a transfer of property that
                is made voluntarily and gratuitously with no promise of anything
                of value to be provided in return, adds the judicial center.
                Additionally, failing to deliver on a promised gift is not
                considered an enforceable &quot;breach of contract.&quot; Such a
                breach, along with remedies and enforcement related to those
                breaches, will be explored further later.
              </p>
            </div>

            <div className='mb-4'>
              <h3 className='mb-2 text-xl font-semibold text-gray-800'>
                Acceptance
              </h3>
              <p className='text-gray-700'>
                Acceptance, with respect to a contract deals, with the
                unambiguous nature by which an agreement is solidified. This may
                be done verbally, or through performance or deed, notes the
                university.
              </p>
            </div>

            <div className='mb-4'>
              <h3 className='mb-2 text-xl font-semibold text-gray-800'>
                Mutuality
              </h3>
              <p className='text-gray-700'>
                The fourth element of a valid contract is mutuality. Simply
                stated, this element requires both parties to understand the
                terms and substance of an agreement.
              </p>
            </div>

            <p className='mb-4 text-gray-700'>
              Additionally, many legal experts also point to the elements of
              &quot;capacity&quot; and &quot;legality&quot; as necessary to
              create a legally binding contract agreement. If an individual
              attempts to enter into a contract without the ability to
              reasonably understand what they are doing&mdash;individuals under
              the influence of alcohol, for example, may be deemed unable to
              enter into a contract&mdash;a judge may find a valid contract
              agreement was unable to be properly executed. In turn, that
              contract agreement may be voided due to the absence of the
              capacity element.
            </p>
            <p className='text-gray-700'>
              Similarly, contracts must also fall within the scope of existing
              law in order to be considered valid. Contracts created in friction
              with the law may be considered to lack &quot;legality&quot; and
              may also be invalidated should they be challenged in a court of
              law.
            </p>
          </ContentSection>

          {/* Types of Contracts */}
          <ContentSection
            id='types'
            title='What are the different types of contracts?'
          >
            <p className='mb-4 text-gray-700'>
              Just as there are several different areas where contracts are
              generally used, and there are many common elements of a valid
              contract, there are also several different types of contracts.
            </p>
            <p className='mb-4 text-gray-700'>
              The type of contract used depends on a number of factors. Those
              factors range from the composition of the parties involved to the
              nature of their relationship and the ultimate goal of the
              agreement. Oftentimes, the type of contract used is dictated by
              the preferences of the parties involved, however, in some
              instances, one type of contract simply doesn&apos;t fit a
              particular circumstance. The Uniform Commercial Code (UCC)
              provides a framework for certain contracts, particularly those
              involving the sale of goods, within the broader area of law.
            </p>
            <p className='mb-4 text-gray-700'>
              Some commonly used types of contracts are:
            </p>
            <ul className='mb-4 list-disc space-y-1 pl-6'>
              <li className='text-gray-700'>Adhesion</li>
              <li className='text-gray-700'>Unilateral</li>
              <li className='text-gray-700'>Bilateral</li>
              <li className='text-gray-700'>Executed</li>
              <li className='text-gray-700'>Aleatory</li>
              <li className='text-gray-700'>Fixed-Price</li>
              <li className='text-gray-700'>Cost-Reimbursement</li>
            </ul>
            <p className='mb-4 text-gray-700'>
              Adhesion contracts, for example, are negotiated between parties of
              uneven bargaining strength. An adhesion contract is drafted by one
              party, which is responsible for setting the terms of the
              agreement, and another party of considerably lesser strength who
              must then decide whether or not those terms are acceptable.
            </p>
            <p className='mb-4 text-gray-700'>
              On the other hand, a unilateral contract involves one entity
              making a promise to another should a given set of circumstances
              take place. This contrasts with its counterpart, the bilateral
              contract agreement, which involves both parties making a promise
              in order to fulfill the terms of a given agreement.
            </p>
            <p className='text-gray-700'>
              Furthermore, according to information from the U.S. Department of
              State, a fixed-price contract, for example, involves an agreement
              between a buyer and seller who each agree in advance on what
              constitutes full payment for services and supplies provided in a
              contract. In contrast, a cost-reimbursement contract is used when
              the amount of work cannot be &quot;definitely described&quot; or
              it is difficult to estimate the costs with any &quot;reasonable
              degree of certainty.&quot;
            </p>
          </ContentSection>

          {/* Differences */}
          <ContentSection
            id='differences'
            title='The differences between a contract and an agreement'
          >
            <p className='mb-4 text-gray-700'>
              While a contract is undoubtedly a type of agreement, not all
              agreements constitute a legally binding contract. In order to form
              a contract, the above-stated elements must all be present in the
              document and its surrounding acknowledgments. Parties can agree to
              all sorts of things, but in order for that agreement to be
              enforceable by law, a very specific set of elements must be
              included. The legal concept of specific performance may come into
              play when addressing breaches of contract, and adherence to the
              statute of frauds is essential for certain types of agreements.
            </p>
            <p className='mb-4 text-gray-700'>
              There are a number of different types of agreements commonly
              observed in day-to-day business activity. While not all agreements
              are contracts, some, though, do rise to that level. Thomson
              Reuters coverage of the Master Service Agreement (MSA) provides
              some helpful insights into one common agreement between vendors
              and clients. Understanding the dynamics of bargaining power is
              crucial for contracting parties to negotiate and establish fair
              and equitable agreements.
            </p>
            <p className='mb-4 text-gray-700'>
              (MSAs) are broad, foundational contract arrangements outlining the
              scope of the relationship between two entities doing business with
              one another. Additionally, a companion component of an MSA is the
              Statement of Work (SoW), which lays out highly specific
              expectations and timelines with respect to a given project.
            </p>
            <p className='mb-4 text-gray-700'>
              The SoW is a powerful tool for businesses, municipalities, and
              individuals looking to facilitate a working relationship with one
              another. Oftentimes, an SoW is deployed when two independent
              parties desire to work together toward the mutual completion of a
              work project or goal. The document, which can vary in size and
              complexity, provides important details with respect to the actual
              tasks needed to reach that mutual goal.
            </p>
            <p className='text-gray-700'>
              Further still, an &quot;indemnity agreement&quot; is another
              important legal pact between parties that often plays an important
              role in personal and business dealings. An indemnity agreement is
              &quot;an arrangement whereby one party agrees to pay the other
              party for any damages regardless of who is at fault.&quot; This is
              similar to a &quot;hold harmless agreement,&quot; which ensures
              one party will not be held for tort liability &quot;arising out of
              the indemnitor&apos;s negligent act or omission.&quot;
            </p>
          </ContentSection>

          {/* Breach of Contract */}
          <ContentSection
            id='breach'
            title='What constitutes a breach of contract?'
          >
            <p className='mb-4 text-gray-700'>
              A counteroffer during negotiations may lead to modifications in
              the terms, and these interactions are integral to the framework of
              civil law. While form contracts offer standardized terms, parties
              are obligated to act in good faith during negotiations and
              throughout the life of the contract. Sometimes, obligations arise
              from an implied contract, emphasizing the dynamic nature of the
              law of contracts.
            </p>
            <p className='mb-4 text-gray-700'>
              Unfortunately, sometimes parties dispute the terms of a written or
              verbal contract, or even whether or not a valid contract existed
              in the first place. Parties frequently accuse one another of
              misrepresentation with respect to their intentions, inadequate
              performance, or even outright lying. Oftentimes, these
              disagreements require some form of arbitration or adjudication.
            </p>
            <p className='mb-4 text-gray-700'>
              Breach of contract is one common form of disagreement over a
              contract agreement. A breach of contract is &quot;a failure,
              without legal excuse, to perform any promise that forms all or
              part of the contract. This includes failure to perform in a manner
              that meets the standards of the industry or the requirements of
              any express warranty or implied warranty, including the implied
              warranty of merchantability.&quot;
            </p>
            <p className='mb-4 text-gray-700'>
              When deciding a breach of contract case, a judge must consider
              several important questions, notes the educational center. First,
              a judge must determine if a contract did, in fact, exist. Once
              that determination is made, a judge will then consider what the
              requirements of that contract were, if it was at any point
              modified, and then if a breach occurred.
            </p>
            <p className='mb-4 text-gray-700'>
              Then, a judge must decide if that breach was &quot;material&quot;
              to the terms of the contract and what potential legal defenses
              might apply to the breaching party. Finally, a judge would have to
              determine what damages took place as a result of the breach.
            </p>
            <p className='text-gray-700'>
              A breach of contract can be material or minor. The parties&apos;
              obligations and remedies depend on which type of breach occurred.
              A breach is material if, as a result of the breaching party&apos;s
              failure to perform some aspect of the contract, the other party
              receives something substantially different from what the contract
              specified.
            </p>
          </ContentSection>

          {/* Final Words */}
          <ContentSection id='final-words' title='Final words'>
            <p className='mb-4 text-gray-700'>
              The understanding of contracts is embedded in the fabric of the
              broader legal system, influencing interactions at personal and
              professional levels. Legal contracts are important to understand
              as they are the foundation of a company or party&apos;s
              relationship with another company, its clients, or even its
              employees. Knowing what contracts are, how they are crafted, and
              what their roles are in the legal ecosystem will help law firms
              and businesses know how to effectively manage them.
            </p>
            <p className='mb-4 text-gray-700'>
              To that end, those in need of such agreements can jumpstart their
              drafting process with Practical Law&apos;s up-to-date documents
              and clauses filled with drafting annotations, notes, and
              negotiation tips, provided in the recommended legal language of
              expert attorney-editors.
            </p>
            <p className='text-gray-700'>
              Practical Law is a phenomenal resource for drafting all your
              contracts, agreements, and clauses, and it has helped lawyers and
              attorneys from remarkably diverse backgrounds do just that.
              Standard templates provide starting points to set up these
              documents, and those templates are coupled with insights from
              experts who have years of experience in their practice areas.
            </p>
          </ContentSection>

          {/* Explore Articles CTA */}
          <CTASection />
        </div>
      </main>
    </div>
  );
}
