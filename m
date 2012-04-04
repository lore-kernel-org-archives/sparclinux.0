From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 04 Apr 2012 07:25:12 +0000
Subject: Re: Sparc-32 debian wheezy package repository at http://developer.gaisler.net/debian/
Message-Id: <CAGRGNgXZ60hbVzd5W+U0rAhq3CvemLxpGnL5eLCKs6F53jG_Uw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4F7BF320.1040506@gaisler.com>
In-Reply-To: <4F7BF320.1040506@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Konrad,

On Wed, Apr 4, 2012 at 17:07, Konrad Eisele <konrad@gaisler.com> wrote:
> Debian wheezy sparc-32 package repository:
> http://developer.gaisler.net/debian/

Awesome work!

> For cross compilation of debian packages there is a
> sparc-linux-gnu crosscompiler with many libraries preinstalled:
> http://developer.gaisler.net/debian/cross-compiler/sparc-linux-gnu-cross_1.0.0-1_amd64.deb
> This package is for a 64-bit machine.

crosstool-ng (which Sam has contributed Sparc support to) is another
way to easily build a cross compiler. buildroot is another
alternative.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
