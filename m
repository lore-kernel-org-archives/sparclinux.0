From: David Miller <davem@davemloft.net>
Date: Wed, 07 May 2008 22:49:39 +0000
Subject: Re: [BUG] 2.6.26-rc1 lost half the RAM on UltraSPARC 5
Message-Id: <20080507.154939.172601631.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <18465.63175.561233.228014@alkaid.it.uu.se>
In-Reply-To: <18465.63175.561233.228014@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Wed, 7 May 2008 20:36:55 +0200

> Now that 2.6.26-rc1 boots on my Ultra5, I noticed that it
> reports having only 128MB RAM, while earlier kernels reported
> the correct amount: 256MB.
> 
> A diff of the dmesg output from 2.6.25 and 2.6.26-rc1 shows:

Thanks for the report, I'll try to track this one down.

I have a machine configured similarly to your's, so this ought
to not be too difficult to fix... I hope. :-)
