From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 20 May 2012 11:02:29 +0000
Subject: Re: [PATCH 0/8] diverse sparc32 patches (mostly leon related)
Message-Id: <CAGRGNgVSJRnTXWv1zDtv9eK3Q-QH=-7xyqppy-UjqbrpQn1VFA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120520060009.GA18477@merkur.ravnborg.org>
In-Reply-To: <20120520060009.GA18477@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Sam,

On Sun, May 20, 2012 at 4:00 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> I have looked a bit more into proper integration of leon.
> Following is a few random patches as spin-off by this.
>
> I actually considered creating mm/mmu_viking.c, mm/mmu_turbosparc.c etc.
> But for now I left it all in srmmu.c.
>
> As I introduced a dedicated traptable file for sparc32, I renamed
> the sparc64 variant.
> This change is not build tested (lacks sparc64 gcc on this box).

Builds fine on Sparc64 for me.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
