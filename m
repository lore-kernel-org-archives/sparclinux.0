From: Julian Calaby <julian.calaby@gmail.com>
Date: Fri, 30 Dec 2011 22:47:10 +0000
Subject: Re: [PATCH] sparc32: remove unused file: include/asm/pgtsun4.h
Message-Id: <CAGRGNgX0BAzj8wuF+uo8QdJYNd5rc6UeexPuerPqiw_ZfD6toQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20111230123521.GA4478@merkur.ravnborg.org>
In-Reply-To: <20111230123521.GA4478@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi Sam,

On Sat, Dec 31, 2011 at 01:16, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Fri, Dec 30, 2011 at 03:10:33PM +0100, Sam Ravnborg wrote:
>> On Fri, Dec 30, 2011 at 11:44:28PM +1100, Julian Calaby wrote:
>> > Sam,
>> >
>> > I understand if this isn't used at all, but this seems to be Sun4C
>> > stuff, so why isn't it used - are these defines defined elsewhere?
>>
>> The SUN4C stuff is defined in arch/sparc/include/asm/pgtsun4c.h
>
> The diff between pgtsun.h and pgtsun4c.h is very small.
> The relevant part of the diff is below:
>
> @@ -9,10 +10,10 @@
> =A0#include <asm/contregs.h>
>
> =A0/* PMD_SHIFT determines the size of the area a second-level page table=
 can map */
> -#define SUN4C_PMD_SHIFT =A0 =A0 =A0 22
> +#define SUN4C_PMD_SHIFT =A0 =A0 =A0 23
>
> =A0/* PGDIR_SHIFT determines what a third-level page table entry can map =
*/
> -#define SUN4C_PGDIR_SHIFT =A0 =A0 =A0 22
> +#define SUN4C_PGDIR_SHIFT =A0 =A0 =A0 23
> =A0#define SUN4C_PGDIR_SIZE =A0 =A0 =A0 =A0(1UL << SUN4C_PGDIR_SHIFT)
> =A0#define SUN4C_PGDIR_MASK =A0 =A0 =A0 =A0(~(SUN4C_PGDIR_SIZE-1))
> =A0#define SUN4C_PGDIR_ALIGN(addr) (((addr)+SUN4C_PGDIR_SIZE-1)&SUN4C_PGD=
IR_MASK)
> @@ -23,9 +24,9 @@
> =A0#define SUN4C_REAL_PGDIR_MASK =A0 =A0 =A0 =A0(~(SUN4C_REAL_PGDIR_SIZE-=
1))
> =A0#define SUN4C_REAL_PGDIR_ALIGN(addr) (((addr)+SUN4C_REAL_PGDIR_SIZE-1)=
&SUN4C_REAL_PGDIR_MASK)
>
> -/* 16 bit PFN on sun4c */
> -#define SUN4C_PFN_MASK 0xffff
> -
> +/* 19 bit PFN on sun4 */
> +#define SUN4C_PFN_MASK 0x7ffff
> +
> =A0/* Don't increase these unless the structures in sun4c.c are fixed */
> =A0#define SUN4C_MAX_SEGMAPS 256
> =A0#define SUN4C_MAX_CONTEXTS 16
>
>
> I stripped aways the parts which was in comments and white-space only.

Ok, that makes sense then.

Thanks!

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
