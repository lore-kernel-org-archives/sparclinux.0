From: Andrew Murray <andrew.murray@arm.com>
Date: Mon, 26 Nov 2018 11:12:36 +0000
Subject: [PATCH v2 20/20] perf/core: remove unused perf_flags
Message-Id: <1543230756-15319-21-git-send-email-andrew.murray@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
In-Reply-To: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Now that perf_flags is not used we remove it.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 include/uapi/linux/perf_event.h       | 2 --
 tools/include/uapi/linux/perf_event.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index f35eb72..ba89bd3 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -445,8 +445,6 @@ struct perf_event_query_bpf {
 	__u32	ids[0];
 };
 
-#define perf_flags(attr)	(*(&(attr)->read_format + 1))
-
 /*
  * Ioctls that can be done on a perf event fd:
  */
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index f35eb72..ba89bd3 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -445,8 +445,6 @@ struct perf_event_query_bpf {
 	__u32	ids[0];
 };
 
-#define perf_flags(attr)	(*(&(attr)->read_format + 1))
-
 /*
  * Ioctls that can be done on a perf event fd:
  */
-- 
2.7.4
