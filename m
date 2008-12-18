From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Thu, 18 Dec 2008 14:12:20 +0000
Subject: Re: kernel crashes on Sun Fire 480R with cassini network driver
Message-Id: <20081218141220.GD20418@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20080923133152.GC17211@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20080923133152.GC17211@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Dec 17, 2008 at 07:44:36PM -0800, David Miller wrote:
> Could you please get one of those JTAG SCAN dumps after
> the crash, and provide the exact kernel image and System.map
> file for me to download somewhere?

I reproduced a crash with the current debian 2.6.24-etchnhalf.1-sparc64-smp
kernel, and the relevant files from /boot are on:

http://www.iwr.uni-heidelberg.de/ftp/linux/sparc-boot/

The initrd is also included, console with the JTAG SCAN
output is in crash.console.

Please tell me if you need anything else.
Thanks for looking at it.

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
