From: David Miller <davem@redhat.com>
Date: Wed, 03 Jun 2020 01:38:11 +0000
Subject: Re: [PATCH 1/5] silo: Build with -fno-PIC to reduce size
Message-Id: <20200602.183811.2280702224470805284.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Matt Turner <mattst88@gmail.com>
Date: Sat, 23 May 2020 13:22:29 -0700

> Otherwise the resulting image will be too large:
> 
> | ./util second.map second.aout second2.aout second.b second.b2
> | Distance between two changes larger than 63K 3 84553 0
> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Applied.
