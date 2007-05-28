From: gregsparc@sunsmoke.org
Date: Mon, 28 May 2007 00:50:34 +0000
Subject: SILO MMU Miss problem located
Message-Id: <200705280133.l4S1XfE5028506@sunsmoke.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I may have located one of the sources of the "Fast Data Access MMU Miss"
problem. Unfortunately, I don't know enough about the environment to fix it.


I modified my copy of silo-1.4.13 to print out where in second.b it was
executing. The point where my systems die is line 1485 in main.c

.../silo-1.4.13/second/main.c:1485
	int len = *(unsigned int *)kernel_params;

This line never completes. 

If anyone knows more about this or has a patch they'd like me to try,
please let me know. It's probably not helpful, but my guess is that there's
some kind of alignment problem.

gregsparc@sunsmoke.org
(also in #splack on freenode)

-Greg


