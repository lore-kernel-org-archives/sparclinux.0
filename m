From: Bob <bo-liu@hotmail.com>
Date: Fri, 12 Dec 2008 02:16:52 +0000
Subject: where forked child task first return?
Message-Id: <COL115-W66A1309552B49F8E7C76509FF90@phx.gbl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


when task is forked, it will copy his parent's kernel stack.
 
Then when first time switch_to a new created task, will change to its kernel stack.
 
But, in switch_to macro will " ldd [%%sp + 0x38], %%i6 ", for child task, stack frame is copyed 
 
from parent, so %%i6 will also the same as the parent's .
 
so switch to child task will return to parent's kernel stack again ?
 

---
Best regards

Bo Liu
_________________________________________________________________
Explore the seven wonders of the world
http://search.msn.com/results.aspx?q=7+wonders+world&mkt=en-US&form=QBRE
