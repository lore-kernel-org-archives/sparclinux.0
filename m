From: Meelis Roos <mroos@math.ut.ee>
Date: Fri, 30 Jan 2004 20:35:39 +0000
Subject: Re: SILO 1.4.2 released
Message-Id: <Pine.GSO.4.44.0401302217450.2307-100000@math.ut.ee>
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

before load_file: image_base@00, ret_offset=0
before parse_executable: same.
after parse_executable: same.

This is the load_file+parse_executable in the "else" block, just before
kernel_params is assigned 0 and if(solaris).

kernel_params pointer is FFC00000.

Data Access Exception occurs after this conditional assign to
kernel_params.

Putting in some checkpoints shows that the data access exception comes
from the block
if (kernel_params( {
	...
}

I saw the announcement about 1.4.4 but will try it tomorrow - it's
really getting too late.

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/


