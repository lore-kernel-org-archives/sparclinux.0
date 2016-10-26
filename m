From: James Clarke <jrtc27@jrtc27.com>
Date: Wed, 26 Oct 2016 20:05:36 +0000
Subject: Re: [PATCH] sparc64: Handle extremely large kernel TSB range flushes sanely.
Message-Id: <20161026200536.GA5465@Jamess-MacBook.local>
List-Id: <sparclinux.vger.kernel.org>
References: <20161025.224442.1417439049113609110.davem@davemloft.net>
In-Reply-To: <20161025.224442.1417439049113609110.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Wed, Oct 26, 2016 at 03:04:59PM -0400, David Miller wrote:
> From: James Clarke <jrtc27@jrtc27.com>
> Date: Wed, 26 Oct 2016 18:21:06 +0100
>
> >> On 26 Oct 2016, at 18:09, David Miller <davem@davemloft.net> wrote:
> >>
> >> From: James Clarke <jrtc27@jrtc27.com>
> >> Date: Wed, 26 Oct 2016 17:58:16 +0100
> >>
> >>>> On 26 Oct 2016, at 16:54, David Miller <davem@davemloft.net> wrote:
> >>>>
> >>>> From: James Clarke <jrtc27@jrtc27.com>
> >>>> Date: Wed, 26 Oct 2016 09:28:05 +0100
> >>>>
> >>>>> Any progress on TLB flushing?
> >>>>
> >>>> I'll keep plugging away at it today.
> >>>
> >>> Great; let me know if you need a guinea pig, as it=E2=80=99s pretty e=
asy for me to
> >>> reproduce.
> >>
> >> Will do, what kind of cpus do you have?
> >
> > * UltraSparc T5 (Niagara5)
> > * UltraSparc T1 (Niagara)
> > * UltraSPARC IIIi
> >
> > The IIIi seems to be down at the moment though.
>
> James, here is what I have so far.  I only gave it a brief testing on
> sun4v, so no guarantees for the sun4u cases.  This is against the
> current sparc GIT tree.
>
> The cut-off is 32 pages, we can discuss whether that's a good value
> to use or not.  FWIW, x86_64 has similar code for this situation and
> uses a cut-off of 33.  Perhaps 64 is a better value, who knows.
>
> It might even make sense to use a different cut-off for the hypervisor
> case since the hypervisor trap we have to use to do the TLB operation
> adds even more expense to each iteration of the range loop.
>
> The policy implemented for huge range flushes below is:
>
> 1) Spitfire - Flush all non-locked entries, by hand using diagnostic
>    TLB accesses.
>
> 2) Cheetah - Flush all non-locked entries using "flush all" operation.
>
> 3) sun4v/hypervisor - Flush entire kernel context, which does not
>    remove locked or "permanent" entries.
>
> Anyways, let me know how it goes.

Thanks for this, it's now compiling. I'll let you know if it works
within the next 24 hours.

Before I forget, what do you think about the following patch? I know
Debian used to use the 64-bit kernel for a 32-bit sparc userland, and so
"Architecture: sparc" was correct, but obviously sparc64 also exists. It
seems more sane to make sparc64 default to "Architecture: sparc64", with
sparc users needing to override this with KBUILD_DEBARCH if they want
to, rather than providing a setup that's broken out of the box for
sparc64 users.

From: James Clarke <jrtc27@jrtc27.com>
Date: Wed, 26 Oct 2016 20:17:10 +0100
Subject: [PATCH] builddeb: Add support for sparc64

Signed-off-by: James Clarke <jrtc27@jrtc27.com>
---
 scripts/package/builddeb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 8ea9fd2..63b3112 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -41,6 +41,8 @@ set_debarch() {
 		debarch=3D"$UTS_MACHINE" ;;
 	x86_64)
 		debarch=3Damd64 ;;
+	sparc64)
+		debarch=3Dsparc64 ;;
 	sparc*)
 		debarch=3Dsparc ;;
 	s390*)
--
2.9.3

