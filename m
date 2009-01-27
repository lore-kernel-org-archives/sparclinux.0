From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Tue, 27 Jan 2009 09:33:09 +0000
Subject: Re: Sunfire V880 and 480R 2.6.27.x startup hangs
Message-Id: <20090127093309.GA2644@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jan 26, 2009 at 11:04:39AM +0100, Hermann Lauer wrote:
> 
> Not getting much futher, only a "Setting up of bus", see below. 
> The full console output I leave on:
> 
> http://www.iwr.uni-heidelberg.de/ftp/linux/sparc-boot/console20090126.txt
> 
> Is that ok or should I always attach the complete console ?
> If time permits I'll test on a 480R, too. Thanks.

Just to confirm myself: the 480R hangs at the same point, so some
change is in the kernel which make of_bus_driver_init unhappy
on this types of machines. Full console log is available at:

http://www.iwr.uni-heidelberg.de/ftp/linux/sparc-boot/console480R20090127.txt

Hermann

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
