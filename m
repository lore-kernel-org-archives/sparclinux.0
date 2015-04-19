From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 19 Apr 2015 23:08:47 +0000
Subject: Re: IOMMU patch seems to work fine on older sparcs
Message-Id: <CAGRGNgV2+nNvBfHAbMeuMYzFsLzpXwVbfyypMKuaHiowX-19Ww@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1504192155340.11284@math.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1504192155340.11284@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Meelis,

On Mon, Apr 20, 2015 at 5:00 AM, Meelis Roos <mroos@linux.ee> wrote:
> I tried todays git (4.0.0-08110-g64fb1d0 on most, the first round on
> some) on my currently active sparc64 testbed. Seems to work fine so far
> (debian upgrade + local git clone in loop), no visible regressions
> comapred to 4.0. The machines include:
>
> Ultra 1
> Ultra 2 (US II CPU)
> Ultra 5
> V100
> Netra X1
> Blade 100
> V440
> T2000
>
> More test machines will follow but the first round is fine. Good work!

I was hoping to test these patches on my Ultra 1e, but it got some
form of hardware fault and won't turn on and I haven't found time to
debug it yet, however as it works on your Ultra 1, I'll put fixing it
on the back burner.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
