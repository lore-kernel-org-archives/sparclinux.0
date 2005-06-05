From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 05 Jun 2005 03:13:14 +0000
Subject: Re: 2.6.11.10 failure on Hypersparc sparc32 [was: Re: sparc32 2.6
Message-Id: <Pine.LNX.4.61.0506042301270.9294@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0505190111530.13987@bobcat>
In-Reply-To: <Pine.LNX.4.61.0505190111530.13987@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 4 Jun 2005, Bob Breuer wrote:

> As for execve failing, can you print out the value of errno when it fails?

Hi Bob,

execve call does not return, so it presumably succeeds. After this piece 
in init/do_mounts_initrd.c:handle_initrd()

         pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
         if (pid > 0) {
                 while (pid != sys_wait4(-1, &i, 0, NULL))
                         yield();
         }

i has the value of 11, which according to my research indicates that it 
was terminated by SIGSEGV. If you have any ideas on how to debug it 
further, please let me know.

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
