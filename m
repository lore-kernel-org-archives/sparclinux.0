From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 11 Jan 2005 18:49:51 +0000
Subject: Re: Current BK kernel error
Message-Id: <20050111184951.GA14443@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050111143605.GC4514@artsapartment.org>
In-Reply-To: <20050111143605.GC4514@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jan 11, 2005 at 08:36:05AM -0600, Art Haas wrote:
> A pull of the current BK kernel failed to build, with an error in
> mm/memory.c about pte_read() not being defined. This function was added
> in at revsion 1.204, and the 'bk prs' with this comment:
> D 1.204 05/01/04 18:48:23-08:00 gnb@melbourne.sgi.com[torvalds] 213 212 18/2/215
> 6
> P mm/memory.c
> C oprofile: add check_user_page_readable()
> The pte_read() function is defined at include/asm-sparc64/pgtable.h for
> 64-bit Sparc, but is not defined for 32-bit Sparc. Anyone taken a shot
> at making a patch for this yet?

According to Bob Breuer, returning 1 always seems to work for ordinary
userspace (as opposed to "unusual" programs). I've got documentation,
so I'll brew up something more accurate for it over the weekend.


-- wli
