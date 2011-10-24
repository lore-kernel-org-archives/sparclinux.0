From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Mon, 24 Oct 2011 14:43:06 +0000
Subject: Re: 3.0.4 kernel oops in i2c ?
Message-Id: <20111024144306.GH15939@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20111014144345.GB5070@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20111014144345.GB5070@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Oct 24, 2011 at 03:26:56PM +0200, Josip Rodin wrote:
> On Fri, Oct 14, 2011 at 04:43:45PM +0200, Hermann Lauer wrote:
> > when starting 3.0.4 on a V880 a non fatal oops happens when loading
> > i2c stuff. Proably there is a problem with i2c on the machine,
> > as the rsc "env" cmd shows "E880_FSP: ERROR getting FP stats ---> 9"
> > errors. An old 2.6.26-2-sparc64-smp (Debian 2.6.26-26lenny2) kernel
> > produces no oops.
> 
> Can you try the stable Debian 2.6.32 kernel at least?
> 
> Anything that helps you reduce the amount of git bisect...

2.6.32-5-sparc64-smp (Debian 2.6.32-38) (ben@decadent.org.uk) (gcc version 4.3.5 (Debian 4.3.5-4) ) #1 SMP Mon Oct 3 09:43:44 UTC 2011

is starting fine without oops. Thanks for caring,

 Hermann

> 
> -- 
>      2. That which causes joy or happiness.
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
