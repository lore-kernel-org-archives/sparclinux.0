From: David Miller <davem@davemloft.net>
Date: Sun, 24 Aug 2008 05:35:08 +0000
Subject: collection of prtconf dumps...
Message-Id: <20080823.223508.30992690.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I find myself often referring to prtconf dumps to try and diagnose bug
reports and write new code.

So I took the existing examples/ directory from the prtconf sources,
and added dumps from a bunch of systems I personally have.

There is a GIT tree:

	master.kernel.org:/pub/scm/linux/kernel/git/davem/prtconfs.git

and for the GIT challenged I tarred up a copy:

	http://vger.kernel.org/~davem/prtconfs.tar.gz

If you have a machine or weird configuration not present, please
send me the "/usr/sbin/prtconf -pv" output from it and I'll add
it to the collection.

It's very easy to contribute to this, so please do!

Thanks!
