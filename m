From: Ben Collins <bcollins@debian.org>
Date: Fri, 30 Jan 2004 20:06:42 +0000
Subject: Re: SILO 1.4.2 released
Message-Id: <20040130200642.GE695@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040129182954.GK532@phunnypharm.org>
In-Reply-To: <20040129182954.GK532@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jan 30, 2004 at 09:59:09PM +0200, Meelis Roos wrote:
> > Can you get the silo source and do some compiles for me? Would be easier
> > than me sending you loaders and waiting. I need you to check the address
> > image_base and ret_offset in the function bootmain() in the file
> > second/main.c. Just add some printf's.
> 
> It doesn't reach the end of the function.
> 
> > Also, you can try commenting out the call to memory_release() at the
> > bottom of that same file/function.
> 
> Removing this call doesn't change anything.
> 
> Will continue to narrow it down.

Look for where it sets the value for the kernel_params pointer. Add a
line after it sets it:

	printf("kernel_params=%x\n", kernel_params);

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
