From: Chris Newport <crn@netunix.com>
Date: Fri, 04 Mar 2005 11:10:31 +0000
Subject: Re: [PATCH] sparc: fix compile failure ("struct resource" related)
Message-Id: <42284227.9000308@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050301134440.05ae1152.akpm@osdl.org>
In-Reply-To: <20050301134440.05ae1152.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David S. Miller wrote:

>>In general, you should not need to have the Sun firmware in your
>>drivers, just upload them to the card and array from Solaris and they
>>will stay there in nvram.
>>    
>>
>
>Not true if you boot from the SOC/SOCAL disks, OBP will load it's
>own firmware which is very slow and has tons of debugging enabled
>in it.
>  
>
Oook - that is EVIL.
We really do not want to taint the kernel with Sun's FCode.

I think we could work around this, the OBP is all in FORTH
so we should be able to replace the offending upload function
with a one line null function in nvramrc.
Would this work ?.

Caveat - this theory comes from the decaying memory of a 60
year old Fortran hacker and needs to be properly researched
in the OBP documentation. Significant ForthHackery maybe required.

