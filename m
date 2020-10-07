From: Christoph Hellwig <hch@infradead.org>
Date: Wed, 07 Oct 2020 06:16:59 +0000
Subject: Re: SPARC version of arch_validate_prot() looks broken (UAF read)
Message-Id: <20201007061659.GA21685@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <CAG48ez3YsfTfOFKa-Po58e4PNp7FK54MFbkK3aUPSRt3LWtxQA@mail.gmail.com>
 <0fb905cc-77a2-4beb-dc9c-0c2849a6f0ae@oracle.com>
 <CAG48ez3istGAOA=G8fvrQkbMs4MroT8bj=Z=Wmnj0k73K0AFRA@mail.gmail.com>
In-Reply-To: <CAG48ez3istGAOA=G8fvrQkbMs4MroT8bj=Z=Wmnj0k73K0AFRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jann Horn <jannh@google.com>
Cc: Khalid Aziz <khalid.aziz@oracle.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, Khalid Aziz <khalid@gonehiking.org>, kernel list <linux-kernel@vger.kernel.org>, Anthony Yznaga <anthony.yznaga@oracle.com>, Andrew Morton <akpm@linux-foundation.org>

On Wed, Oct 07, 2020 at 02:45:39AM +0200, Jann Horn wrote:
> > I think arch_validate_prot() is still the right hook to validate the
> > protection bits. sparc_validate_prot() can iterate over VMAs with read
> > lock. This will, of course, require range as well to be passed to
> > arch_validate_prot().
> 
> In that case, do you want to implement this?

Any reason to not just call arch_validate_prot after taking the mmap
lock?
