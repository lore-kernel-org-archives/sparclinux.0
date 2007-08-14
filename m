From: "jiaqi zhang" <zation.busy@gmail.com>
Date: Tue, 14 Aug 2007 03:26:49 +0000
Subject: Re: Physical cpu number on UltrasparcT1
Message-Id: <a8e8903d0708132026jb77dcdi659beda8e8fe10f0@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a8e8903d0708131434j1c1e2b81m5f3fb6e9c6d1a0ab@mail.gmail.com>
In-Reply-To: <a8e8903d0708131434j1c1e2b81m5f3fb6e9c6d1a0ab@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> You can look at the files under /sys/devices/system/cpu/cpu${ID}/topology/
> to see this information.
However, I find "topology" an empty directory:(

> This datastructure is parsed and managed in arch/sparc64/kernel/mdesc.c,
> in particular you might find mdesc_fill_in_cpu_data() useful.

However, I'm using kernel version 2.6.20, which has not included your
files on proper multi-core scheduling support yet. Is that neccessary
to build a 2.6.22 kernel to achieve my goal? Because in that case I
should contact the hypervisor and discuss this problem.
