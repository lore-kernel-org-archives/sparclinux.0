From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 22 Jul 2015 11:25:58 +0000
Subject: Re: [PATCH V4 5/6] mm: mmap: Add mmap flag to request VM_LOCKONFAULT
Message-Id: <20150722112558.GC8630@node.dhcp.inet.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <1437508781-28655-1-git-send-email-emunson@akamai.com>
 <1437508781-28655-6-git-send-email-emunson@akamai.com>
In-Reply-To: <1437508781-28655-6-git-send-email-emunson@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric B Munson <emunson@akamai.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.cz>, Vlastimil Babka <vbabka@suse.cz>, Paul Gortmaker <paul.gortmaker@windriver.com>, Chris Metcalf <cmetcalf@ezchip.com>, Guenter Roeck <linux@roeck-us.net>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org

On Tue, Jul 21, 2015 at 03:59:40PM -0400, Eric B Munson wrote:
> The cost of faulting in all memory to be locked can be very high when
> working with large mappings.  If only portions of the mapping will be
> used this can incur a high penalty for locking.
> 
> Now that we have the new VMA flag for the locked but not present state,
> expose it as an mmap option like MAP_LOCKED -> VM_LOCKED.

What is advantage over mmap() + mlock(MLOCK_ONFAULT)?

-- 
 Kirill A. Shutemov
