From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Fri, 06 Feb 2009 10:28:25 +0000
Subject: Re: Sunfire V880 and 480R 2.6.27.x startup hangs
Message-Id: <20090206102825.GA6446@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Feb 03, 2009 at 03:19:18PM -0800, David Miller wrote:
> From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
> Date: Tue, 3 Feb 2009 22:26:32 +0100
> 
> > Maybe it's important that this is a two cpu machine (as a similar 6
> > cpu machine seems to work, see other report on the list) ?
> 
> I don't think it matters, to be honest.  Memory size and layout
> may have more to do with it.

I bisected meanwhile the complete versions from 2.6.26 to 2.6.27 series:

<2.6.26.8	boots
 2.6.27-rc1	compile fails (see below)
>2.6.27-rc2	hangs at boot

Any chance that one of the last memory related patches will fix
this problem ? Thanks.

  CC      arch/sparc64/kernel/iommu.o
In file included from arch/sparc64/kernel/iommu.c:21:
arch/sparc64/kernel/iommu_common.h:40: error: static declaration of iommu_num_pages follows non-static declaration
include/linux/iommu-helper.h:11: error: previous declaration of iommu_num_pages was here

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
