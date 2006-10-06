From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Fri, 06 Oct 2006 04:49:40 +0000
Subject: [sparc32] 2.6.19-rc1 build error: no tickadj
Message-Id: <20061006044940.GA9372@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Stock 2.6.19-rc1 will not build for sparc32, because tickadj got
removed and arch/sparc/kernel/time.c still uses it:
http://www.ussg.iu.edu/hypermail/linux/kernel/0608.2/1742.html

Does anyone know the proper fix for this?

Thanks,
-- 
Martin
