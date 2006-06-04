From: Meelis Roos <mroos@linux.ee>
Date: Sun, 04 Jun 2006 16:13:38 +0000
Subject: Re: [PATCH]: Fix D-cache corruption in mremap()
Message-Id: <Pine.SOC.4.61.0606041913030.29655@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20060601.175258.41634623.davem@davemloft.net>
In-Reply-To: <20060601.175258.41634623.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>> Works on my Ulta 5 - without the patch I get the error at once and with
>> the patch I get no error for half an hour.
>
> Great, please watch for any dpkg database file corruption.  That's the
> reason all of this started :)

Seems to have survived a large debian update since the patch was in 
place, so it seems to work. Thanks!

-- 
Meelis Roos (mroos@linux.ee)
