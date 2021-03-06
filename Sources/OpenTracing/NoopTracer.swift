import Foundation

private struct NoopGlobals {
    static let tracer = NoopTracer()
    static let span = NoopSpan()
    static let context = NoopSpanContext()
}

/// A tracer implementation that does nothing.
/// This is useful for guaranteeing that a tracer reference is non-nil.
public struct NoopTracer: Tracer {

    public func extract(reader: FormatReader) -> SpanContext? {
        return NoopGlobals.context
    }

    public func inject(spanContext: SpanContext, writer: FormatWriter) {}

    public func startSpan(operationName: String, references: [Reference]?, tags: [String : Codable]?,
                          startTime: Date?) -> Span
    {
        return NoopGlobals.span
    }
}

public struct NoopSpan: Span {
    
    public var context: SpanContext {
        return NoopGlobals.context
    }

    public func tracer() -> Tracer {
        return NoopGlobals.tracer
    }

    public func setOperationName(_ operationName: String) {}

    public func finish(at time: Date) {}

    public func log(fields: [String: Codable], timestamp: Date) {}

    public func baggageItem(withKey key: String) -> String? {
        return nil
    }

    public func setBaggageItem(key: String, value: String) {}

    public func setTag(key: String, value: Codable) {}
}

public struct NoopSpanContext: SpanContext {
    public func forEachBaggageItem(callback: (String, String) -> Bool) {}
}
