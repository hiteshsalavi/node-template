import { Request, Response, NextFunction } from 'express';

// This enforeces controller to be void instead of returning a promise, and catches any unhandled promise rejections and passes them to the next middleware (error handler)
export function WrapController(controllerFunc: (req: Request, res: Response, next: NextFunction) => Promise<void>) : (req: Request, res: Response, next: NextFunction) => void {
  return (req: Request, res: Response, next: NextFunction) => {
    controllerFunc(req, res, next).then(() => {
        // Post controller logic can be added here if needed
        // May be useful for logging, metrics, etc.
    }).catch((error) => {
        console.error("Error in controller:", error);
        next(error);
    });
  };
}