From: mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez)
Date: Tue, 26 Oct 2004 06:28:19 +0000
Subject: Re: Booting an Ultra sparc with 2.6
Message-Id: <20041026062819.GN17506@ruslug.rutgers.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <20040913143811.GH30464@ruslug.rutgers.edu>
In-Reply-To: <20040913143811.GH30464@ruslug.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Oct 26, 2004 at 01:16:04AM -0500, Andrew Gaffney wrote:
> Luis R. Rodriguez wrote:
> >On Mon, Oct 25, 2004 at 07:53:28PM -0700, David S. Miller wrote:
> >
> >>On Mon, 25 Oct 2004 20:32:12 -0400
> >>mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez) wrote:
> >>
> >>
> >>>a. boot into vmlinux (48MB)
> >>>	result: image too large
> >>
> >>Please, why in the world do you need a 48MB kernel
> >>image?
> >
> >Hey -- I can reduce the size, sure but that is besides the point. I want
> >to know the details of the size limitations of the kernel image for
> >sparc64. You told me last that there was no size limitations, that this
> >was fixed in the latest version of silo.
> 
> It is something closer to "no unreasonable size limit". I believe the limit 
> is 7.5MB, which should more than enough for *any* kernel you'd ever need to 
> compile.

Andrew, thanks -- and *that* is what I needed. I'll try to reduce my
kernel size now. I swear, I have been trying to limit it as much as I
can already I guess I'll have to try harder :)

Anyone know *why* this 7.5MB limit exists?

	Luis

-- 
GnuPG Key fingerprint = 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E
