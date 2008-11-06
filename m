From: Robert Reif <reif@earthlink.net>
Date: Thu, 06 Nov 2008 03:03:52 +0000
Subject: sparc boot failure
Message-Id: <49125E98.8070905@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sparc has failed to boot recently and I bisected it down to this patch:

8dd9453737822469837d48d5da3785ce70fb2118 is first bad commit
commit 8dd9453737822469837d48d5da3785ce70fb2118
Author: Frederic Weisbecker <fweisbec@gmail.com>
Date:   Tue Oct 21 21:56:42 2008 -0700
 
    sparc: correct section of current_pc()
     
    Latest mainline gives this section mismatch on sparc:
     
    The function current_pc() references
    the variable __init no_sun4u_here.
    This is often because current_pc lacks a __init
    annotation or the annotation of no_sun4u_here is wrong.
     
    Since current_pc() is used only in early time, it is correct to
    put it in .init section.
     
    Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

Reverting this patch gets current git booting again.
 

