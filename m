From: Jim Gifford <maillist@jg555.com>
Date: Tue, 03 Jan 2006 17:39:19 +0000
Subject: Re: SILO 1.4.10
Message-Id: <43BAB6C7.2070203@jg555.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1136175018.27583.50.camel@grayson>
In-Reply-To: <1136175018.27583.50.camel@grayson>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Further testing is showing the elftoaout built as 64bit will create all 
the files except for second.b correctly. Which is kinda of wierd.

Further testing when compiled silo as 64 bit(just did it to see) the 
same issue only second.b is not created properly. Compared to the 32 bit 
build the .b files are the same except for second.b.

So we have 2 potential issues

1 - elftoaout is not creating proper files when it's compiled as 64bit
2 - second.b is not being created properly

-- 
----
Jim Gifford
maillist@jg555.com

