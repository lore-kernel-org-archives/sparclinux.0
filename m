From: Meelis Roos <mroos@ut.ee>
Date: Sat, 23 Aug 2008 06:49:17 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100 - USB again
Message-Id: <Pine.SOC.4.64.0808230948340.2459@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> You can use "eeprom" as root, something like:
> 
> eeprom ttya-mode="9600,8,n,1,-"

Yes, thank you, I didn't know about that!
apt-get install sparc-utils and modprobe openprom and it really did the 
trick.

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
