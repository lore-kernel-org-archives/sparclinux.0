From: Jann Horn <jannh@google.com>
Date: Wed, 07 Oct 2020 00:45:39 +0000
Subject: Re: SPARC version of arch_validate_prot() looks broken (UAF read)
Message-Id: <CAG48ez3istGAOA=G8fvrQkbMs4MroT8bj=Z=Wmnj0k73K0AFRA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAG48ez3YsfTfOFKa-Po58e4PNp7FK54MFbkK3aUPSRt3LWtxQA@mail.gmail.com>
 <0fb905cc-77a2-4beb-dc9c-0c2849a6f0ae@oracle.com>
In-Reply-To: <0fb905cc-77a2-4beb-dc9c-0c2849a6f0ae@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, Khalid Aziz <khalid@gonehiking.org>, kernel list <linux-kernel@vger.kernel.org>, Anthony Yznaga <anthony.yznaga@oracle.com>, Andrew Morton <akpm@linux-foundation.org>

On Tue, Sep 29, 2020 at 7:30 PM Khalid Aziz <khalid.aziz@oracle.com> wrote:
> On 9/28/20 6:14 AM, Jann Horn wrote:
> > From what I can tell from looking at the code:
> >
> > SPARC's arch_validate_prot() looks up the VMA and peeks at it; that's
> > not permitted though. do_mprotect_pkey() calls arch_validate_prot()
> > before taking the mmap lock, so we can hit use-after-free reads if
> > someone concurrently deletes a VMA we're looking at.
>
> That makes sense. It will be a good idea to encapsulate vma access
> inside sparc_validate_prot() between mmap_read_lock() and
> mmap_read_unlock().
>
> >
> > Additionally, arch_validate_prot() currently only accepts the start
> > address as a parameter, but the SPARC code probably should be checking
> > the entire given range, which might consist of multiple VMAs?
> >
> > I'm not sure what the best fix is here; it kinda seems like what SPARC
> > really wants is a separate hook that is called from inside the loop in
> > do_mprotect_pkey() that iterates over the VMAs? So maybe commit
> > 9035cf9a97e4 ("mm: Add address parameter to arch_validate_prot()")
> > should be reverted, and a separate hook should be created?
> >
> > (Luckily the ordering of the vmacache operations works out suIch that
> > AFAICS, despite calling find_vma() without holding the mmap_sem, we
> > can never end up establishing a vmacache entry with a dangling pointer
> > that might be considered valid on a subsequent call. So this should be
> > limited to a rather boring UAF data read, and not be exploitable for a
> > UAF write or UAF function pointer read.)
> >
>
> I think arch_validate_prot() is still the right hook to validate the
> protection bits. sparc_validate_prot() can iterate over VMAs with read
> lock. This will, of course, require range as well to be passed to
> arch_validate_prot().

In that case, do you want to implement this?
When I try to figure out how to implement this based on your
suggestion, it ends up a bit ugly because either mprotect has to do
some extra checks before calling the hook or the hook has to deal with
potentially (partly) unmapped userspace ranges in the supplied range
and then figure out what to do about those. (And for extra fun, it
also has to be safe against concurrent find_extend_vma() but should
probably also not change what happens when the first half of the given
address range is mapped and the second half is not mapped? Or does the
latter not matter?)
It'd also be annoying for me to test since I don't have any setup for
testing SPARC stuff (let alone SPARC ADI).
