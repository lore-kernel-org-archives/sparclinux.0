From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Mon, 27 Jul 2015 14:03:55 +0000
Subject: Re: [PATCH V5 5/7] mm: mmap: Add mmap flag to request VM_LOCKONFAULT
Message-Id: <20150727140355.GA11360@node.dhcp.inet.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <1437773325-8623-1-git-send-email-emunson@akamai.com>
 <1437773325-8623-6-git-send-email-emunson@akamai.com>
 <20150727073129.GE11657@node.dhcp.inet.fi>
 <20150727134126.GB17133@akamai.com>
In-Reply-To: <20150727134126.GB17133@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric B Munson <emunson@akamai.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.cz>, Vlastimil Babka <vbabka@suse.cz>, Paul Gortmaker <paul.gortmaker@windriver.com>, Chris Metcalf <cmetcalf@ezchip.com>, Guenter Roeck <linux@roeck-us.net>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org

On Mon, Jul 27, 2015 at 09:41:26AM -0400, Eric B Munson wrote:
> On Mon, 27 Jul 2015, Kirill A. Shutemov wrote:
> 
> > On Fri, Jul 24, 2015 at 05:28:43PM -0400, Eric B Munson wrote:
> > > The cost of faulting in all memory to be locked can be very high when
> > > working with large mappings.  If only portions of the mapping will be
> > > used this can incur a high penalty for locking.
> > > 
> > > Now that we have the new VMA flag for the locked but not present state,
> > > expose it as an mmap option like MAP_LOCKED -> VM_LOCKED.
> > 
> > As I mentioned before, I don't think this interface is justified.
> > 
> > MAP_LOCKED has known issues[1]. The MAP_LOCKED problem is not necessary
> > affects MAP_LOCKONFAULT, but still.
> > 
> > Let's not add new interface unless it's demonstrably useful.
> > 
> > [1] http://lkml.kernel.org/g/20150114095019.GC4706@dhcp22.suse.cz
> 
> I understand and should have been more explicit.  This patch is still
> included becuase I have an internal user that wants to see it added.
> The problem discussed in the thread you point out does not affect
> MAP_LOCKONFAULT because we do not attempt to populate the region with
> MAP_LOCKONFAULT.
> 
> As I told Vlastimil, if this is a hard NAK with the patch I can work
> with that.  Otherwise I prefer it stays.

That's not how it works.

Once an ABI added to the kernel it stays there practically forever.
Therefore it must be useful to justify maintenance cost. I don't see it
demonstrated.

So, NAK.

-- 
 Kirill A. Shutemov
