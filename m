From: David Miller <davem@davemloft.net>
Date: Fri, 22 Aug 2008 23:10:26 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100 - USB again
Message-Id: <20080822.161026.88861217.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@ut.ee>
Date: Fri, 22 Aug 2008 19:49:34 +0300 (EEST)

> Or can I use some linux command line to change nvram variables?
> "setenv ttya-mode 9600,8,n,1,-" is needed.

You can use "eeprom" as root, something like:

eeprom ttya-mode="9600,8,n,1,-"
