From: Meelis Roos <mroos@linux.ee>
Date: Tue, 10 Mar 2009 17:03:38 +0000
Subject: Re: sunhme: SBUS QFE not detected anymore
Message-Id: <Pine.LNX.4.64.0903101901300.9904@ondatra.tartu-labor>
List-Id: <sparclinux.vger.kernel.org>
References: <49B4632D.7010606@gentoo.org>
In-Reply-To: <49B4632D.7010606@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Setting sbus_dp = to_of_device(op->dev.parent->parent)->node will
> therefore get "SUNW,Ultra-2" instead of "sbus".

Tested successfully on E3500 too. I inserted a SBus quad hme, it was not 
detected with current git kernel. Applied the patch, booted, not it was 
detected. Nice work!

-- 
Meelis Roos (mroos@linux.ee)
