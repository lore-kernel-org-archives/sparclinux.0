From: Jann Horn <jannh@google.com>
Date: Wed, 07 Oct 2020 06:31:08 +0000
Subject: Re: SPARC version of arch_validate_prot() looks broken (UAF read)
Message-Id: <CAG48ez3pwkpoeHTSSuRHpmdn7X5AVuGjw5n3VhD88S1p0cjsUg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAG48ez3YsfTfOFKa-Po58e4PNp7FK54MFbkK3aUPSRt3LWtxQA@mail.gmail.com>
 <0fb905cc-77a2-4beb-dc9c-0c2849a6f0ae@oracle.com> <CAG48ez3istGAOA=G8fvrQkbMs4MroT8bj=Z=Wmnj0k73K0AFRA@mail.gmail.com>
 <20201007061659.GA21685@infradead.org>
In-Reply-To: <20201007061659.GA21685@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: Khalid Aziz <khalid.aziz@oracle.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, Khalid Aziz <khalid@gonehiking.org>, kernel list <linux-kernel@vger.kernel.org>, Anthony Yznaga <anthony.yznaga@oracle.com>, Andrew Morton <akpm@linux-foundation.org>

On Wed, Oct 7, 2020 at 8:17 AM Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Oct 07, 2020 at 02:45:39AM +0200, Jann Horn wrote:
> > > I think arch_validate_prot() is still the right hook to validate the
> > > protection bits. sparc_validate_prot() can iterate over VMAs with read
> > > lock. This will, of course, require range as well to be passed to
> > > arch_validate_prot().
> >
> > In that case, do you want to implement this?
>
> Any reason to not just call arch_validate_prot after taking the mmap
> lock?

Then the next easy steps are:

 - change the signature of arch_validate_prot() to also accept a
length or end parameter (because a start address without an end
address is completely useless)
 - add a loop over the VMAs in that range in SPARC's arch_validate_prot()

And then comes the annoying part: figure out what to do in that loop
if the range is not fully covered by VMAs. To fully avoid changing the
normal mprotect() ABI, you'd have to accept cases where parts of the
range are unmapped - but hopefully nobody relies on that particular
weirdness, so maybe you can just throw an error in that case? Even so,
the normal error code for that is -ENOMEM, but arch_validate_prot()
has a boolean return, so for that, you'd have to change the return
type, too. I guess the cleanest approach might be to just validate up
to the first gap and then return "everything's good" and rely on
mprotect() bailing out on its own?

Ah - at first I thought that you'd also have to deal with concurrent
stack VMA expansion from find_expand_vma() (which we really should get
rid of somehow sometime), but luckily that still at least holds the
mmap lock in read mode, and here we hold it in write mode, so we don't
have to worry about that. So I guess that'd be the way to go for this
approach?

Alright, I guess I'll send patches after all, hopefully after at least
compile-testing them...
