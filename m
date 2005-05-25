From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Wed, 25 May 2005 22:44:36 +0000
Subject: Re: NR_CPUS and kernel 2.4.30 for sparc64
Message-Id: <4294FFD4.2080403@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <4294E414.80003@wp.pl>
In-Reply-To: <4294E414.80003@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David S. Miller wrote:
> You must set CONFIG_NR_CPUS to one plus the largest "physical cpu"
> number in your machine if you want all processors to be detected
> properly.  In your case, the correct setting would be 3.
> 
> 
> 

This works differnetly than on sparc32 kernel (it works there).

I thought about the second condition from my previous post (elimnation 
of last cpu from the list of cpus). As far as I can see,  the max_cpus 
is always equal to NR_CPUS (is it true?). If so, the second condition is 
redudant (cpucount is always < NR_CPUS).


