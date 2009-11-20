From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Fri, 20 Nov 2009 14:28:03 +0000
Subject: Re: [experimental patch] sungem: force serdes dection on buildin V880 fiber gigabit ethernet
Message-Id: <20091120142803.GB19931@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20091113124350.GA1926@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20091113124350.GA1926@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Nov 17, 2009 at 04:49:28AM -0800, David Miller wrote:
> It seems there is a special device property that we can use
> to detect this properly.
> 
> Please try the attached patch on your system, it should fix
> the problem too.

Works on the SunFire 880 with internel fibre serdes and on a SunFire 480
with a PCI Card with fibre serdes here.

On the PCI card interrestingly there were initially type phy_mii_mdio1 
or phy_mii_mdio0 detected and only after failing to read the phy_mii 
fall back to type phy_serdes. The 'shared-pins' property would be
available for testing for a serdes on that card, too.

But anyways, all interfaces are working. Thanks.

BTW, are there any new ideas about getting post 2.6.26 kernels booting
on that class of sparc machines ? My last try with 2.6.31.6 still
hangs at the usual point. Anything I could/should try ?

The offer of remote debugging on the SunFire 480 still stands,
if you could find a few spare minutes...

Thanks,
  Hermann

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
