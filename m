From: Meelis Roos <mroos@linux.ee>
Date: Fri, 30 Jan 2004 19:59:09 +0000
Subject: Re: SILO 1.4.2 released
Message-Id: <Pine.GSO.4.44.0401302152520.2307-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20040129182954.GK532@phunnypharm.org>
In-Reply-To: <20040129182954.GK532@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Can you get the silo source and do some compiles for me? Would be easier
> than me sending you loaders and waiting. I need you to check the address
> image_base and ret_offset in the function bootmain() in the file
> second/main.c. Just add some printf's.

It doesn't reach the end of the function.

> Also, you can try commenting out the call to memory_release() at the
> bottom of that same file/function.

Removing this call doesn't change anything.

Will continue to narrow it down.

-- 
Meelis Roos (mroos@linux.ee)

