From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 05 Jan 2012 01:53:00 +0000
Subject: Re: SPARC32: forced setting of mode of SUN4M per-cpu timers
Message-Id: <CAGRGNgX0s8XwGEdT+8USY3SLLQGvkC5xjHQD5wFyw3s-93dLPQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1325727738.1385.3.camel@hp>
In-Reply-To: <1325727738.1385.3.camel@hp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Kirill,

I'll leave others to comment on the actual contents of the patch, but
you've made a couple of rookie mistakes in submitting this patch.

Firstly, make sure you put [PATCH] at the start of the subject of the
patch as it makes it easier for people to spot patches as opposed to
general discussion.

On Thu, Jan 5, 2012 at 12:42, Kirill Tkhai <tkhai@yandex.ru> wrote:
> SPARC32: forced setting of mode of SUN4M per-cpu timers
>
> SUN4M per-cpu timers have two modes of work. These are timer mode and
> counter mode. SPARC32 doesn't write anything to the register, which is
> connected with mode choice. So, the mode is chosen by bootloader. This
> patch forces to use timer mode from the kernel and to be independent of
> bootloader.
>
> I had this problem with OpenBIOS. Timers don't tick and kernel fails on
> QEMU, when it's compiled with SMP support. The path fixes problem.

Spelling mistake: "patch" not "path"

You're missing your Signed-off-by: line. You must have a line at the
bottom of your patch summary like the following:

Signed-off-by: J Random Developer <jrdeveloper@example.com>

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
