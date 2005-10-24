From: Jakub Jermar <jermar@itbs.cz>
Date: Mon, 24 Oct 2005 12:24:29 +0000
Subject: SILO and load address
Message-Id: <435CD27D.80109@itbs.cz>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I am having troubles with SILO loading my ELF image 
(non-linux kernel). The problem is that the kernel is not 
loaded to the address wich is specified in the ELF, but to 
some other address. Is there a workaround for that? Or do I 
miss the point?

Best regards,
Jakub
