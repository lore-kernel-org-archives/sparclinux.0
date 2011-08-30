From: Jim Faulkner <jfaulkne@ccs.neu.edu>
Date: Tue, 30 Aug 2011 23:01:10 +0000
Subject: Re: bug report: Sun Blade 100 kernel panics during boot under 3.0.3
Message-Id: <20110830230109.GB24856@alumni-linux.ccs.neu.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
In-Reply-To: <20110822233839.GA7793@alumni-linux.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Well, I've made a little bit of progress.  linux-2.6.21.7 boots, while
linux-2.6.22.19 does not.  With the latter kernel, this is the last
message before the machine hangs:
mem_init: Calling free_all_bootmem().

linux-2.6.23.17 exhibits the same symptom.  I'll start testing the
2.6.22-rc kernels until I narrow down the problem kernel.

