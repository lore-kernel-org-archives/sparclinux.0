From: Bernd Zeimetz <bernd@bzed.de>
Date: Sun, 16 Dec 2007 22:41:19 +0000
Subject: Re: Fix for sparc64 cpu hangs.
Message-Id: <4765A98F.2060806@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20071106.203433.144763156.davem@davemloft.net>
In-Reply-To: <20071106.203433.144763156.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


>> I'll leave the kernel running and make sure the machine gets some more
>> users and load during the next days.
> 
> Thanks for testing, let me know if any more issues trigger.

One problem I was pointed to was the build failure of erlang. Here the
created erlc binary segfaults with a bus error.

- this only happens on US III machines, works fine on US II.

- on lebrun it doesn't happen on the first call of erlc, but after
several successful runs of it - see
http://buildd.debian.org/fetch.cgi?&pkg=erlang&ver=1%3A11.b.5dfsg-11&arch=sparc&stamp97012623&file=log

- on our v880 here (which is still running the kernel with your test
patch) erlc segfaults instantly. A strace shows that it is stuck at a
well known place - pretty similar to the segfault in aptitude which
successfully shot the machine to death before your patch(es) was(were)
applied:

[pid  1224] clone(Process 1228 attached
child_stack=0xf7951480,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
parent_tidptr=0xf7951bd8, tls=0xf7951b90, child_tidptr=0xf7951bd8) = 1228
[pid  1224] SYS_300(0xf7951be0, 0xc, 0, 0, 0xf7951df4) = 0
[pid  1224] futex(0xff993338, 0x80 /* FUTEX_??? */, 2

... there it hangs.


I guess you should be able to reproduce this on your US III machine.
dget -x \
ftp://debian.netcologne.de/debian/pool/main/e/erlang/erlang_11.b.5dfsg-11.dsc
cd erlang-11.b.5dfsg
dpkg-buildpackage -rfakeroot
(you'll probably have to install some build-deps...)
when erlc segfaults, change into the directory and set

ERL_TOP=/home/bzed/erlang-11.b.5dfsg
PATH=/home/bzed/erlang-11.b.5dfsg/bootstrap/bin:${PATH}

before retrying to run erlc.


Let me know if you need more informations or want me to test something.


-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>
